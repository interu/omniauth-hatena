# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require File.expand_path('../lib/omniauth/hatena/version', __FILE__)


Gem::Specification.new do |s|
  s.name        = "omniauth-hatena"
  s.version     = OmniAuth::Hatena::VERSION
  s.authors     = ["NUNOKAWA Masato"]
  s.email       = ["masato.nunokawa@gmail.com"]
  s.homepage    = 'https://github.com/nunocky/omniauth-hatena'
  s.summary     = 'Hatena OAuth strategy for OmniAuth'
  s.description = %q{Hatena OAuth strategy for OmniAuth}

  s.rubyforge_project = "omniauth-hatena"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'omniauth-oauth', '> 0.4.5'

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
