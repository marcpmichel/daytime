require File.expand_path('../lib/daytime/version', __FILE__)

Gem::Specification.new do |s|
	s.name         = 'daytime'
	s.version      = Daytime::VERSION
	s.author       = 'marcpmichel'
	s.email        = 'marc.p.michel@gmail.com'
	s.homepage     = 'http://patatra.fr/daytime'
	s.summary      = 'simple time-only class'
	s.description  = 'Manage only 24 hours time to the second. Internally use the number of seconds since the beginning of day'

	s.files          = `find . -print`.split("\n")
	s.executables    = []
	s.test_files     = `ls -1 spec/*`.split("\n")
	s.require_paths  = ['lib']

	s.add_development_dependency 'rspec'
end
