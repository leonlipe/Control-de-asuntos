Gem::Specification.new do |s|
  s.name    = 'active_form'
  s.version = '1.0.3'
  s.date    = '2009-03-16'

  s.summary = "Validations for Non Active Record Models"

  s.authors  = ['Christoph Schiessl']
  s.email    = 'c.schiessl@gmx.net'
  s.homepage = 'http://github.com/cs/active_form'

  s.has_rdoc = false
  s.add_dependency 'activemodel', ['>= 3.0.0.rc']
  s.add_dependency 'activesupport', ['>= 3.0.0.rc']

  s.files = %w(init.rb lib lib/active_form.rb MIT-LICENCE Rakefile test)
  s.test_files = %w(test/test_helper.rb test/basic_test.rb)
end
