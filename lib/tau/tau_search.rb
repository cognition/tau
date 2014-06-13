##
# writen by Ramon Brooker <rbrooker@aetherealmind.com>
# (c) 2013
##


require 'pg'
require 'yaml'
class TauSearch


    def initialize
      database_connection = YAML.load_file("../config/database.yml")
      @conn = PG::Connection.open(database_connection["tau_db"])
      @query = {
        "all" => "SELECT ip_address FROM tau_db.tau_system_db ",
        "room" => "SELECT n.ip_address FROM tau_db.tau_system_db WHERE room = <%= room_number ",
        "floor" => "SELECT n.ip_address FROM tau_db.tau_system_db WHERE floor = <%= floor_number %>"
      }
    end


# @TODO test for units that have ip and no room
# @TODO need to create a query to search by group id

  def find_ip_address(query_type,value=nil)
    cmd = @query[query_type]
    if value != "1"
      vls = "'" + value.to_s.gsub(/,/, '\',\'').chomp + "'"
      cmd.gsub!(/THEVALUE/, vls)
    end
      ips_csv = String.new
      ips = @conn.exec(cmd)
      ips = ips.values
      size = ips.count - 1
      (0..size).each do |n|
        ips_csv << "'#{ips[n][0]}',"
      end
    return ips_csv.chop!
  end
end

## to Check Connection
## uncomment below and run with
#  $ ruby tau_search.rb
#
# t = TauSearch.new
# f = t.find_ip_address('floor',4)
# puts "\nfloor 4 \n #{f}"
# r = t.find_ip_address('room','824,622,616')
# puts "\nrooms\n\t824\t622\t616\n\n #{r}"
# a = t.find_ip_address('all')
# puts "\n all \n #{a}"



