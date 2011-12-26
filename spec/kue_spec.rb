require 'spec_helper'

describe KueStore do
  it 'should have the kue_settings table correctly setup' do
    ActiveRecord::Base.connection.table_exists?(:kue_settings).should be_true
  end
  
  it 'should save a new key and value' do
    proc { KueStore[:key_one] = "Key One"}.should_not raise_error
  end
  
  it 'should retrieve a keys value' do
    KueStore[:key_two] = "Key Two"
    KueStore[:key_two].should == "Key Two"
  end
  
  it 'should save and retrieve complex objects' do
    proc { KueStore[:key_three] = Math }.should_not raise_error
    KueStore[:key_three].sqrt(100).should == 10
  end
  
  it 'should check for existance' do
    KueStore.exists?(:non_existant).should be_false

    KueStore[:existant] = 109
    KueStore.exists?(:existant).should be_true
  end
  
  it 'should delete a key and value' do
    KueStore[:delete_me] = 1098
    KueStore.exists?(:delete_me).should be_true
    KueStore.delete!(:delete_me).should be_true
    KueStore.exists?(:delete_me).should be_false
  end
  
  it 'should not throw an error when deleting a key that does not exist' do
    KueStore.delete!(:non_existant).should be_false
  end
  
  it 'should be able to list all keys' do
    KueStore[:k1] = 1
    KueStore[:k2] = 2
    KueStore[:k3] = 3
    KueStore.keys.should == [:k1, :k2, :k3]
  end
end