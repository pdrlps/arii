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
require 'spreadsheet'

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

        # update headers default behaviour
        if object[:headers] == ''
          object[:headers] = 0
        end

        # different gems and implementation for XLSX and XLS
        if object[:uri].ends_with? 'xlsx'
          book = RubyXL::Parser.parse(open(object[:uri]))

          if object[:sheet] != ''
            sheet = book[object[:sheet]]
          else
            sheet = book[0]
          end

          sheet.extract_data.drop(object[:headers]).each do |row|
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
        else if object[:uri].ends_with? 'xls'
          Spreadsheet.client_encoding = 'UTF-8'
          book = Spreadsheet.open(open(object[:uri]))

          if object[:sheet] != ''
            sheet = book.worksheet [object[:sheet]]
          else
            sheet = book.worksheet 0
          end



          sheet.each object[:headers] do |row|
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
        end

      end
    rescue Exception => e
      Services::Slog.exception e
    end
  end
end
end
