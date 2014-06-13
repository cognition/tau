# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tau/version.rb'
require 'tau/tau_search.rb'
require 'tau/add_command.rb'


Gem::Specification.new do |spec|
  spec.name          = "tau"
  spec.version       = Tau::VERSION
  spec.authors       = ["Ramon Brooker"]
  spec.email         = ["rbrooker@aetherealmind.com"]
  spec.description   = %q{Tau is a server side ruby program that connect to Rooted Android System}
  spec.summary       = %q{Tau is a server side ruby program that connect to Rooted Android System by creating an ssh handshake and sends a discrete set of commands. This is used when an Android device has an ssh server running and adb disabled.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
#   spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency "sinatra"
  spec.add_dependency "thor"
  spec.add_dependency "net-ssh", "~> 2.7"

end
