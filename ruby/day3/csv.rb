# Modify the CSV application to support an each method to return a CsvRow object.
# Use method_missing on that CsvRow to return the value for the column for a given heading.
#
# For example, for the file:
#
# one, two
# lions, tigers
#
# allow an API that works like this:
#
# csv = RubyCsv.new
# csv.each {|row| puts row.one}
#
# This should print "lions"

module ActsAsCsv
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_csv
      include InstanceMethods
    end
  end
end

module InstanceMethods
  def read
    @csv_contents = []
    filename = self.class.to_s.downcase + '.txt'
    file = File.new(filename)
    @headers = file.gets.chomp.split(', ')

    file.each do |row|
      @csv_contents << row.chomp.split(', ')
    end
  end

  attr_accessor :headers, :csv_contents

  def initialize
    read
  end
end

class RubyCsv
  include ActsAsCsv
  acts_as_csv

  def each(&block)
    @csv_contents.each { |row_contents| block.call(CsvRow.new(@headers, row_contents)) }
  end
end

class CsvRow
  attr_accessor :headers, :row_contents

  def initialize(headers, row_contents)
    @headers = headers
    @row_contents = row_contents
  end

  def self.respond_to_missing?
    true
  end

  def method_missing(name, *args)
    for i in 0..@headers.length do
      if name.to_s == @headers[i]
        return @row_contents[i]
      end
    end
    super
  end
end

csv = RubyCsv.new
csv.each { |row| puts row.one }
csv.each { |row| puts row.two }
