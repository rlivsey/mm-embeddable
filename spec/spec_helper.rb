$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
gem 'rspec', '1.3.0'

require 'mm-embeddable'
require 'spec'
require 'spec/autorun'
require 'spec/mocks'
require 'mocha'

class TestUser
  include MongoMapper::Document
  
  key :login, String
  key :name, String
  key :bio, String
  
  embeds :login, :name
end

class TestMessage
  include MongoMapper::Document
  
  key :sender, TestUser::Embeddable
  many :receivers, :class_name => 'TestUser::Embeddable'
  
  key :subject, String
  key :body, String
end

require File.expand_path(File.dirname(__FILE__) + "/blueprints")

MongoMapper.database = 'mm_plugin_test'

Spec::Runner.configure do |config|
  config.mock_with :mocha
  config.before(:all)    { Sham.reset(:before_all)  }
  config.before(:each)   { Sham.reset(:before_each); }#MongoMapper.connection.drop_database('mm_plugin_test') }
end
