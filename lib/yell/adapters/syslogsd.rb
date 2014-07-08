module Yell
  module Adapters
    class Syslogsd < Yell::Adapters::Base

      attr_accessor :host, :port, :facility, :prefix
      
      setup do |opts|
        @host = Yell.__fetch__(opts, :host, :default => 'localhost')
        @port = Yell.__fetch__(opts, :port, :default => 514)
        @facility = Yell.__fetch__(opts, :facility, :default => $0)
        @prefix = Yell.__fetch__(opts, :prefix, :default => '')
        @mapping = Yell.__fetch__(opts, :mapping, :default => :logger)

        @instance = SyslogSD::Logger.new @host, @port
        @instance.level_mapping = @mapping
      end
      
      def yank_hashes_from *messages
        messages.select{|m| m.is_a? Hash}.reduce(&:merge) || {}
      end

      def get_combined_message *messages
        messages.select{|m| m.is_a? String}.join(' ') || ""
      end
      
      def get_notify_for event, message, data
        data.merge({:short_message => "#{@prefix}#{message}", :level => event.level, :facility => @facility})
      end
      
      write do |event|
        structured_data = yank_hashes_from(*event.messages)
        message = get_combined_message(*event.messages)
        @instance.notify! get_notify_for(event, message, structured_data)
      end
    end
  end
    register :syslogsd, Yell::Adapters::Syslogsd
end
