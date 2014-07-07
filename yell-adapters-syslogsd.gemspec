# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
#require 'yell/adapters/syslogsd/version'

Gem::Specification.new do |spec|
  spec.name          = "yell-adapters-syslogsd"
  spec.version       = '1.0.1' # Yell::Adapters::Syslogsd::VERSION
  spec.authors       = ["Raymond F. Wells"]
  spec.email         = ["rfw2nd@gmail.com"]
  spec.summary       = %q{Connect SyslogSD to Yell}
  spec.description   = %q{Allows one to use syslog-sd with yell.  Supports structured data.}
  spec.homepage      = ""
  spec.license       = "Apache2"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.add_development_dependency 'rspec', '2.14'
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_dependency "yell", "~> 2.0.4"
  spec.add_dependency 'syslog-sd', '~> 1.3.2'
end
