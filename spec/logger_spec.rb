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

  it "convert input into the format expected by syslog-sd" do
    @logger.info "Test", {:with_structured => 1}
    expect($_mock_data).to eq [{:with_structured => 1, :facility => "rspec", :level => 1, :short_message => "Test"}]
  end

  it "should filter out harmful keys" do
    @logger.debug "Test", {:level => 5, :short_message => "HI"}
    expect($_mock_data).to eq [{:level => 0, :facility => "rspec", :short_message => "Test"}]
  end
end
