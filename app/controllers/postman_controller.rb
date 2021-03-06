require 'helper'
require 'delivery'
require 'sqltemplate'
require 'filetemplate'
require 'urltemplate'
require 'mailtemplate'
require 'dropboxtemplate'
require 'raven'

class PostmanController < ApplicationController
  def deliver
    Services::Slog.debug({:message => "Starting delivery to #{params[:identifier]}", :module => "Postman", :task => "deliver", :extra => {:endpoint => params[:identifier], :params => params}})

    @delivery
    begin
      @template = Template.find_by! identifier: params[:identifier]

      case @template[:endpoint]
      when 'sql'
        @delivery = Services::SQLTemplate.new @template
      when 'file'
        @delivery = Services::FileTemplate.new @template
      when 'url'
        @delivery = Services::URLTemplate.new @template
      when 'mail'
        @delivery = Services::MailTemplate.new @template
      when 'dropbox'
        @delivery = Services::DropboxTemplate.new @template
      end
    rescue Exception => e
      @response = { :status => "401", :message => "[ARiiP] Unable to load selected Output", :identifier => params[:identifier], :error => e }
      Services::Slog.exception e
    end

    # stop if output is disabled
    if @template.status != 100
      @response = {:status => 403, :message => '[ARiiP] Selected Output is disabled.', :identifier => params[:identifier]}
      respond_to do |format|
        format.json  {
          render :json => @response
        }
        format.js  {
          render :json => @response
        }
      end
      return
    end

    begin
      @delivery.process params
    rescue Exception => e
      @response = { :status => "402", :message => "[ARiiP] Unable to process input parameters", :identifier => params[:identifier], :error => e, :template => @template }
      Services::Slog.exception e
    end

    begin

      @response = @delivery.execute
    rescue Exception => e
      @response = { :status => "403", :message => "[ARiiP] Unable to perform final delivery, #{e}", :identifier => params[:identifier], :error => e, :template => @template }
      Services::Slog.exception e
    end

    begin
      @template = nil
      @template = Template.find_by! identifier: params[:identifier]
      @template.increment(:count)
      @template.last_execute_at = Time.now
      @template.save
    rescue Exception => e
      Services::Slog.exception e
    end

    respond_to do |format|
      format.json  {
        render :json => @response
      }
      format.js  {
        render :json => @response
      }
      format.xml  {
        render :xml => @response
      }
    end
  end


  def load
    begin
      @t = Template.where(identifier: params[:identifier], endpoint: params[:endpoint])
      if @t.count > 0 then
        response = { :status => "402", :message => "[ARiiP]: output #{params[:identifier]} already exists"}
      else
        attrs = JSON.parse(IO.read("templates/#{params[:endpoint]}/#{params[:identifier]}.js"))
        t = Template.create! attrs
        response = { :status => "200", :message => "[ARiiP]: outut #{params[:identifier]} loaded", :id => "#{t[:id]}" }
      end
    rescue
      response = { :status => "401", :message => "Error: output not found for #{params[:endpoint]} with name #{params[:key]}.", :error =>  $!}
      Services::Slog.exception e
    end

    respond_to do |format|
      format.json  {
        render :json => response
      }
      format.xml {
        render :xml => response
      }
      format.js  {
        render :json => response
      }
    end
  end

  def go
    @host = Services::Helper.hostname
    @date = Services::Helper.date
    @time = Services::Helper.datetime

    t = Template.find_by identifier: params[:identifier]

    if t[:endpoint] == 'sql' then
      @lol = t[:payload][:host] #[:method]
    else
      @lol = t[:payload][:uri]
    end
  end
end
