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

end
