module Yell
  module Adapters
    class Syslogsd < Yell::Adapters::Base

      attr_accessor :host, :port, :facility, :prefix
      
      setup do |opts|
        @host = opts[:host] || 'localhost'
        @port = opts[:port] || 514
        @facility = opts[:facility] || $0
        @prefix = opts[:prefix] || ''

        @instance = SyslogSD::Logger.new @host, @port
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
