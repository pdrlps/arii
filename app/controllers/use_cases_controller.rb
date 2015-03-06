class UseCasesController < ApplicationController
  layout "home"

  def index
    generate_content 'use_cases', 'index'
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
