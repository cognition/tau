##
# writen by Ramon Brooker <rbrooker@aetherealmind.com>
# (c) 2013
##

require "thor"
require File.expand_path("tau/version")
require File.expand_path("tau/tau_command")


module Tau
  class Tau < Thor

    class_option    :all, :alias => :a, :type => :boolean, :banner => "will update the whole fleet"
    #   option    :building, :alias => :H , :type => :string, :banner => "specifies a building(s)"
    class_option    :floor , :alias =>  :F, :type => :string, :banner => "floor number"
    class_option    :room, :alias => :r, :type => :string, :banner => "room number"
    #   option    :group, :type => :string, :banner => "only acts on those units in a group -- also named set"
    #option    :random, :alias => :r, :type => :boolean, :banner => "generates a random set of rooms requires size, name"
    #   if options[:random]
    #     option  :size,  :type => :integer, :required => true, :banner => "carnality of random set"
    #     option  :name,  :type => :string, :required => true, :banner => "name the random set"
    #   end
#     option    :csv, :type => :string, :banner => "specifies a building(s)"
#     option    :file, :type => :string, :banner => "specifies a building(s)"
    #   option    :host, :type => :string, :banner => "specifies a building(s) -- NOT USED"
    #   option    :domain, :type => :string, :banner => "specifies a building(s) -- NOT USED"
#     option    :ibid, :type => :boolean, :banner => "uses the previous commands selections"

    # option    :h, :type  => :boolean, :banner => "Displays this Help"

    desc "optionslist", "prints if the options list"
    def optionslist
      puts "
      #Universal Flags
      ip_address      unit IP address (defaut)

      -a --all        will update the whole fleet
      -H --building   specifies a building(s)
      -F  --floor     floor takes a floor name
      -r  --room      room number
      --group         Acts on those units in a group -- also named set

      -h --help       displays this
      -R --random     Randomly select set of rooms (used for A/B testing)
      --size          used with -R for selecting the number of units to gernerate
      -name           used to give the set a uniq identifier
      --csv           reads comma separed values from STD unless --file is called
      --file          take --file as list of commands in cvs format
      --host          if the address is using a dns hostname with domain   [TODO]
      --domain        if units are using dns hostnames with seperated domains
                      (ie unit.localation.domain.com,  etc.. )  [TODO]
      --ibid          repeat previous options
      -h              displays this message
      "
    end


    desc "man", "displays the help man file"
    def man
      man_txt = File.open('config/help_file.txt')
      puts man_txt.read()
    end


  end
end
