require "open-uri"
require 'csv'
require 'zip'

class CsvDownloader
  
  ZIP_LINK = 'https://www150.statcan.gc.ca/n1/tbl/csv/13100766-eng.zip'
  FILE_NAME = '13100766.csv'

  def initialize

  end

  def parse_csv_string
    CSV.parse(csv_string_removed_quotes, headers: true)
  end

  def read_input_file_into_string(input_file)
    str = File.read(input_file)
    str.gsub('"', '')
  end

  def retrieve_csv
    # parsed_csv_string = read_input_file_into_string("/Users/jameshicklin/Workspace/covid_visualizer_api/public/13100766.csv")

    # parsed_csv = CSV.parse(parsed_csv_string, headers: true)
    # parsed_csv.each do |row|
    #   puts row.inspect
    # end


    # return nil
    url_data = open(CsvDownloader::ZIP_LINK)

    parsed_csv = nil 
    Zip::File.open(url_data) { |zip_file|
      zip_file.each do |f|
        if f.name == CsvDownloader::FILE_NAME
          csv_string = f.get_input_stream.read
          csv_string_removed_quotes = csv_string.gsub('"', '')
          parsed_csv = CSV.parse(csv_string_removed_quotes, headers: true)
        end
      end
    }

    if parsed_csv
      parsed_csv.each do |row|
        puts row.inspect
      end
    end

  end
end