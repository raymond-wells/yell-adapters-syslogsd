require 'yell-adapters-syslogsd'

y = Yell.new do |l|
 l.adapter :stdout
 l.adapter :syslogsd
end

y.info "HI THERE"
y.info "HI THERE STRUCTURED DATA", {:test => 1}
