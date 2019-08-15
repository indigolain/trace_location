# frozen_string_literal: true

require_relative 'trace_location/collector'
require_relative 'trace_location/config'
require_relative 'trace_location/report'
require_relative 'trace_location/version'
require_relative 'trace_location/railtie' if defined?(::Rails::Railtie)

module TraceLocation # :nodoc:
  def self.trace(options = {}, &block)
    match = options.delete(:match)
    ignore = options.delete(:ignore)

    result = Collector.collect(match: match, ignore: ignore, &block)
    Report.build(result.events, result.return_value, options).generate
    true
  rescue StandardError => e
    $stderr.puts "Failure: #{e.message}"
    false
  end

  def self.configure
    yield config
  end

  def self.config
    @config ||= Config.new
  end
end
