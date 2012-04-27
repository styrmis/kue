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
    # Build a new class to have something to store and retrieve.
    class Foo
      attr_accessor :bar
    end
    foo = Foo.new
    foo.bar = 42
    # Store and retrieve the instance.
    proc { KueStore[:key_three] = foo }.should_not raise_error
    KueStore[:key_three].bar.should == 42
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
    proc { KueStore.delete!(:non_existant) }.should_not raise_error
  end

  it 'should list all keys' do
    KueStore[:k1] = 1
    KueStore[:k2] = 2
    KueStore[:k3] = 3
    KueStore.keys.should == [:k1, :k2, :k3]
  end

  it 'should clear the store' do
    KueStore[:k1] = 1
    KueStore[:k2] = 2
    KueStore[:k3] = 3
    KueStore.clear!
    KueStore.keys.should be_empty
  end

  it 'should count all items in the store' do
    KueStore[:k1] = 1
    KueStore[:k2] = 2
    KueStore[:k3] = 3
    KueStore.count.should == 3
  end

  it 'should fail hard if a nil key is passed to []=' do
    proc { KueStore[nil] = 1 }.should raise_error(Kue::KueNilKeyError)
  end

  it 'should return nil if a nil key is passed to []' do
    KueStore[nil].should be_nil
  end
end

describe 'Using Kue::Store outside of the KueStore class - introducing BlueStore!' do
  class BlueStore < ActiveRecord::Base
    include Kue::Store
  end

  it 'should be able to be used as a kue store' do
    BlueStore[:ok] = "One"
    BlueStore[:ok].should == "One"
  end
end