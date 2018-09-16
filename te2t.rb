#!/usr/bin/env ruby

require 'nokogiri'
require 'zip'

# You may want to update this function to map the
# TextExpander abbreviation to the texpander one
# (that needs to be a valid filename.)
def sanitize_abbreviation(abbr)
  chars_to_delete = ['\/', '\*', '^;', ';$']

  abbr.gsub(Regexp.new(chars_to_delete.join('|')), '')
end

###################################################

def process(xml)
  xmldoc = Nokogiri::XML(xml)
  snippets = xmldoc.xpath(
    'plist/dict/key[.=\'snippetPlists\']/following-sibling::*[1]/dict'
  )

  abbreviations = snippets.xpath('key[.=\'abbreviation\']/following-sibling::*[1]').map(&:content)
  expansions = snippets.xpath('key[.=\'plainText\']/following-sibling::*[1]').map(&:content)

  created = 0
  skipped = 0

  abbreviations.zip(expansions).to_h.each do |abbreviation, expansion|
    next if abbreviation.empty?

    filename = sanitize_abbreviation(abbreviation)
    if filename.empty?
      skipped += 1
      next
    end

    File.open(File.expand_path("~/.texpander/#{filename}"), 'w') do |f|
      f.write(expansion)
    end
    created += 1
  end

  return [skipped, created]
end

filename = ARGV[0]
if filename.nil?
  puts "Specify filename of TextExpander backup"
  exit
end

total_created = 0
total_skipped = 0

Zip::File.open(filename) do |zip_file|
  zip_file.each do |file|
    next unless file.name.match(/\.xml$/)

    skipped, created = process(file.get_input_stream.read)
    total_skipped += skipped
    total_created += created
  end
end

puts "Skipped #{total_skipped} snippet(s): invalid abbreviation"
puts "Successfully imported #{total_created} snippets"
