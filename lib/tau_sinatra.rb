##
# writen by Ramon Brooker <rbrooker@aetherealmind.com>
# (c) 2013
##
#  @credits
#  Some Methods where taken from BBC Research and Development github project:
#  https://github.com/bbcrd/REST-API-example
#
# @TODO need to add rack ip filtering for requests


require 'sinatra'
require 'json'
require 'time'

### datamapper requires
require 'data_mapper'
require 'dm-types'
require 'dm-timestamps'
require 'dm-validations'


## logger
def logger
  @logger ||= Logger.new(STDOUT)
# have to alter this to log into a file
end


module StandardProperties
  def self.included(other)
    other.class_eval do
      property :id, other::Serial
      property :created_at, DateTime
    end
  end
end


module Validations
  def valid_id?(id)
    id && id.to_s =~ /^\d+$/
  end
end



class TauIt
  require File.expand_path("tau")
  include DataMapper::Resource
  include StandardProperties
  extend Validations


  property :title, String, :required => true
  property :status, String
end


## set up db
env = ENV["RACK_ENV"]
puts "RACK_ENV: #{env}"
if env.to_s.strip == ""
  abort "Must define RACK_ENV (used for db title)"
end

case env
when "test"
  DataMapper.setup(:default, "sqlite3::memory-tau")
else
  DataMapper.setup(:default, "sqlite3:#{ENV["RACK_ENV"]}-tau.db")
end


## create schema if necessary
DataMapper.auto_upgrade!




## TauRest Sinatra Application
class TauRest < Sinatra::Base
  require File.expand_path("tau/tau_command")
  ## helpers

  def self.put_or_post(*a, &b)
    put *a, &b
    post *a, &b
  end

  helpers do
    def json_status(code, reason)
      status code
      {
        :status => code,
        :reason => reason
      }.to_json
    end

    def accept_params(params, *fields)
      h = { }
      fields.each do |title|
        h[title] = params[title] if params[title]
      end
      h
    end
  end


  ## GET /tau - return all tau#Objects
  get "/tau/?", :provides => :json do
    content_type :json

    if tauit = TauIt.all
      tauit.to_json
    else
      json_status 404, "Not found"
    end
  end

  ## GET /tau/:id - return tau with specified id
  get "/tau/:id", :provides => :json do
    content_type :json

    # check that :id param is an integer
    if TauIt.valid_id?(params[:id])
      if tauit = TauIt.first(:id => params[:id].to_i)
        tauit.to_json
      else
        json_status 404, "Not found"
      end
    else
      json_status 404, "Not found"
    end
  end

# [NOTE] Error with pulling in JSON and passing as json. keeps stringifiting it
  ## POST /tau/ - runs a tau command and create new row in the db
  post "/tau/?", :provides => :json do
    content_type :json

    new_params = accept_params(params, :title, :status)
    tauit = TauIt.new(new_params)
    taucm = TauCommand.new
    puts params
    puts new_params
    puts params["ip_scope"]
    puts params["cmd"]
    puts params["value"]
#     taucm.t_command(params)
    if tauit.save
      headers["Location"] = "/tau/#{tauid.id}"
      status 201 # Created
      tauit.to_json
    else
      json_status 400, tauit.errors.to_hash
    end
  end

  ## misc handlers: error, not_found, etc.

  get "*" do
    status 404
  end
  #
  #
  put_or_post "*" do
    status 404
  end

  delete "*" do
    status 404
  end

  not_found do
    json_status 404, "Not found"
  end

  error do
    json_status 500, env['sinatra.error'].message
  end

end













