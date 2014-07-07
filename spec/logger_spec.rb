require 'yell-adapters-syslogsd'

class SyslogSD::Notifier
  attr_reader :_mock_data
  def notify! *opts
    $_mock_data = opts
  end
end


describe Yell::Adapters::Syslogsd do
  before :each do
    @logger = Yell.new(:syslogsd, {:facility => "rspec"}) 
  end

  it "should handle more than 2 arguments" do
    @logger.info "Hello", "there", "this", "is", "a", "test", {:struct => true}
    expect($_mock_data[0][:short_message]).to eq "Hello there this is a test"
    expect($_mock_data[0][:struct]).to eq true
  end
  
  it "should handle no arguments" do
    @logger.info 
  end
  
  it "should handle multi-line messages" do
    @logger.info "Test\nAnd another"
    expect($_mock_data[0][:short_message]).to eq "Test\nAnd another"
  end
  
  it "convert input into the format expected by syslog-sd" do
    @logger.info "Test", {:with_structured => 1}
    expect($_mock_data).to eq [{:with_structured => 1, :facility => "rspec", :level => 1, :short_message => "Test"}]
  end

  it "should filter out harmful keys" do
    @logger.debug "Test", {:level => 5, :short_message => "HI"}
    expect($_mock_data).to eq [{:level => 0, :facility => "rspec", :short_message => "Test"}]
  end
end
