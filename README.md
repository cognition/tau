# Tau

Tau is a command line/restful api for remote controlling a fleet of Android Tablets (devices).  The devices connect to a server via autossh, set a port in the 8xxxx range, 
the tablet then sends a pakect of information informing a Tau listener to update the database with its specific configuration (eg. ip, domain, port attached, serial_number). 

At that point all functions availible via adb are possible, as well as all availble linux command. One of the primary security features is to not only wipe the device be you can send 
'dd if=/dev/sda of=/dev/sda' thus destroying the tablets os on its hdd, and ineffect bricking it. 



to test classes look in lib/tau/ for tau_search.rb and tau_command.rb
at the bottom of each have tests that need to be uncommnented and run

note: at the moment to test usage by room number floor and all; you need to have a Tau database, with unit ip, room, floor, building, etc.. linked together details in the database.yml config file
You will also need to change/add the queries into tau_search.rb in order to get the right information. 




# Below hasn't been tested yet, as a gem,


## Installation

Add this line to your application's Gemfile:

    gem 'tau'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tau

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


writen by Ramon Brooker <rbrooker@aetherealmind.com>
(c) 2013



