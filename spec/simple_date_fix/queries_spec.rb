require 'spec_helper'


describe 'model validations' do

  let(:klass) { Class.new(AWS::Record::Base) }

  before(:each) do
    klass.datetime_attr :timestamp
    klass.create_domain
    klass.each{|u| u.destroy }
    sleep(2)
  end

  it 'should save and retreive a timestamp correctly' do
    stamp = Time.now
    obj = klass.new :timestamp => Time.now
    obj.save
    AWS::SimpleDB.consistent_reads do
      obj = klass.first
      obj.timestamp.to_i.should == stamp.to_i
    end
  end

  describe 'queyring the timestamp' do
    before(:each) do
      @obj = klass.new :timestamp => (Time.now - 3.hours).utc
      @obj.save
    end

    it "should return the object when we query for timestamps newer than 4 hours ago" do
      AWS::SimpleDB.consistent_reads do
        test_stamp = (Time.now - 4.hours).utc
        obj = klass.where("timestamp > ?",test_stamp).first
        obj.id.should == @obj.id
      end
    end

    it "should not return the object when we query for timestamps newer than 2 hours ago" do
      AWS::SimpleDB.consistent_reads do
        test_stamp = (Time.now - 2.hours).utc
        obj = klass.where("timestamp > ?",test_stamp).first
        obj.should be_nil
      end
    end

  end

end
