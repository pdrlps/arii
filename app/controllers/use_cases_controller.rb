class UseCasesController < ApplicationController
  layout "home"

  def index
    generate_content 'use_cases', 'index'
  end

  def online2rest
  end

  def ticket2email
  end

  def github2database
  end

  def twitter2file
  end

  def customerorders
  end

  def frauddetection
  end

  def datawarehousing
  end

  def operationaldatastores
  end

  def dashboards
  end

  def more
  end

  ##
  # => Read the raw content for documentations
  #
  def generate_content(section, topic)
    begin
      @content = Kramdown::Document.new(File.read('data/docs/arii_' + section + '_' + topic + '.md'), :toc_levels => '1').to_html
    rescue
    end
    @content
  end
end
