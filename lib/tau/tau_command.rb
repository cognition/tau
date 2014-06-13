##
# writen by Ramon Brooker <rbrooker@aetherealmind.com>
# (c) 2013
##

# require File.expand_path("tau/add_command")
require File.expand_path("tau_search")
require "yaml"
require "net/ssh"
require "json"
require "net/scp"

class TauCommand

      def initialize
        @output = ""
        @yaml_file = YAML.load_file("../config/commands.yml")["commands"]
        @ips = ""
      end


      def t_command(ip_input)
        ip_input_hash = JSON.parse(ip_input, :quirks_mode => true)
        if  ip_input_hash["values"].nil?
          @ips = ip_input_hash["ip_scope"]
        end
        if "all,room,floor".include? ip_input_hash["ip_scope"]
          get_ips = PmsiSearch.new
          @ips = get_ips.find_ip_address(ip_input_hash["ip_scope"], ip_input_hash["values"])
        end
        @ips = @ips.split("\',\'")
        push_actions(ip_input_hash["cmd"])
        puts "post"
      end


      # method for sending command to tablets
      def push_actions(input_cmd)
        @ips.each do |ip|
          if @yaml_file[input_cmd].class == Hash
            up_file(ip,@yaml_file[input_cmd])
          else
            up_exec(ip,@yaml_file[input_cmd])
          end
        end
      end

      def up_exec(ip,cmd_action)
        Net::SSH.start(ip,"root", :password => "abc123") do |ssh|
          @output << ssh.exec!(cmd_action.to_s)
          puts @output
        end
      end

      def up_file(ip,cmd_hash)
        puts ip
        puts cmd_hash["from"]
        puts cmd_hash["to"]
          Net::SCP.upload!(ip, "root", cmd_hash["from"] , cmd_hash["to"], :ssh => { :password => "abc123"})
        puts cmd_hash["action"]
        up_exec(ip, cmd_hash["action"])
      end


# JSON FORMAT
#       {"cmd":"[the command title to run]","ip_scope":"[all||room||floor||ip]","values":"[if floor the number, if room the room(s), leave empty for all]}"
#             android_std_ssh_warning = "void endpwent()(3) is not implemented on Android"
end

h = TauCommand.new
# h.t_command("{\"cmd\":\"netcfg \",\"ip_scope\":\"<unit.ip.address>\"}")
# h.t_command("{\"cmd\":\"hostname\",\"ip_scope\":\"<unit.ip.address>\"}")
# h.t_command("{\"cmd\":\"writable\",\"ip_scope\":\"<unit.ip.address>\"}")
# h.t_command("{\"cmd\":\"netcfg\",\"ip_scope\":\"<unit.ip.address>\"}")
# h.t_command("{\"cmd\":\"restart_device",\"ip_scope\":\"<unit.ip.address>\"}")
h.t_command("{\"cmd\":\"update_demo\",\"ip_scope\":\"<unit.ip.address>\"}")

