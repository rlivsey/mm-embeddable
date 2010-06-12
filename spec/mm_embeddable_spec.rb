require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "MongoMapper::Plugins::Embeddable" do
  it { TestUser.should be_respond_to(:embeds) }
  
  it 'should define the Embedded subclass' do
    defined?(TestUser::Embeddable).should be_true
    TestUser::Embeddable.should < MongoMapper::Plugins::Embeddable::EmbeddableDocument
  end
  
  it 'should be able to convert to embedded' do
    TestUser.new.to_embeddable.should be_kind_of(TestUser::Embeddable)
  end
  
  describe '::EmbeddedDocument' do
    it 'should set attributes from a document' do
      mid = BSON::ObjectID.new
      c = TestUser::Embeddable.from_full(stub(:_id => mid, :login => 'abc', :name => 'Bob Bobson', :bio => "A great dude."))
      c.login.should == 'abc'
      c.name.should == 'Bob Bobson'
      c._id.should == mid
      lambda{c.bio}.should raise_error(NoMethodError)
    end
    
    it 'should expand when an attribute is missing' do
      mid = BSON::ObjectID.new
      u = TestUser.new(:_id => mid, :name => "Frank", :bio => 'Once upon a time.')
      TestUser.expects(:find).with(mid).returns(u)
      TestUser::Embeddable.from_full(u).bio.should == 'Once upon a time.'
    end
  end
  
  describe ' in another model' do
    it 'should coerce as a compact document' do
      u1 = TestUser.make
      u2 = TestUser.make
      u3 = TestUser.make
      
      t = TestMessage.make(:sender => u1, :receivers => [u2, u3])
      
      t.reload
      t.sender.should be_kind_of(TestUser::Embeddable)
      t.sender._id.should == u1._id
      t.receivers.first.should be_kind_of(TestUser::Embeddable)
    end
  end
end
