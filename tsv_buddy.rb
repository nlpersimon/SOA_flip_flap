# frozen_string_literal: true

require 'csv'

# Module that can be included (mixin) to take and output TSV data
module TsvBuddy
  def initialize
    @tab = "\t"
  end

  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format
  def take_tsv(tsv)
    @data = CSV.parse(tsv, col_sep: @tab, headers: true).map(&:to_h)
  end

  # to_tsv: converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
    headers = @data.first.keys
    CSV.generate(col_sep: @tab) do |csv|
      csv << headers
      @data.each do |row|
        csv << headers.map { |field| row[field] }
      end
    end
  end
end
