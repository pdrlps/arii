require 'helper'
require 'cashier'
require 'csv'
require 'open-uri'
require 'seedreader'
require 'csvseedreader'
require 'sqlseedreader'
require 'xmlseedreader'
require 'jsonseedreader'
require 'rubyXL'

module Services

  ##
  # = ExcelDetector
  #
  # Detect changes in Excel files.
  #
  class ExcelDetector < Detector

    public
    ##
    # == Detect the changes
    #
    def detect object
      begin
        book = RubyXL::Parser.parse(open(object[:uri]))

        if object[:sheet] != ''
          sheet = book[object[:sheet]]
        else
          sheet = book[0]
        end

        sheet.extract_data.each do |row|
          unless object[:cache].nil?
            @cache = Cashier.verify row[object[:cache].to_i], object, row, object[:seed]
          else
            @cache = Cashier.verify row[0], object, row, object[:seed]
          end
          # The actual processing
          #
          if @cache[:status] == 100

            # add row data to payload from selectors (key => key, value => column name)
            payload = Hash.new
            JSON.parse(object[:selectors]).each do |selector|
              selector.each do |k, v|
                payload[k] = row[v.to_i]
              end
            end
            # add payload object to payloads list
            @payloads.push payload
          end
        end
      rescue Exception => e
        Services::Slog.exception e
      end
    end
  end
end