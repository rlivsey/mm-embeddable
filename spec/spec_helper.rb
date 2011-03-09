$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'rspec'

require 'mm-embeddable'
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

RSpec.configure do |config|
  config.mock_with :mocha
  config.before(:all)    { Sham.reset(:before_all)  }
  config.before(:each)   { Sham.reset(:before_each); }#MongoMapper.connection.drop_database('mm_plugin_test') }
end
