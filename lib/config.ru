##
# writen by Ramon Brooker <rbrooker@aetherealmind.com>
# (c) 2013
##

require "rubygems"
require "sinatra"
require "./tau_sinatra"
require File.expand_path("tau/tau_command")
require File.expand_path("tau/tau_search")
#TauSinatra.public_folder = "/public"


#use Rack::RestApiVersioning
run TauRest

