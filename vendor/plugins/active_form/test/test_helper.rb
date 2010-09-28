require 'rubygems'
require 'test/unit'
require 'active_model'

plugin_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
require File.join(plugin_root, 'lib/active_form')

class Test::Unit::TestCase
  def assert_valid(model, message = nil)
    assert model.valid?, message
  end

  def assert_invalid(model, message = nil)
    assert !model.valid?, message
  end
end
