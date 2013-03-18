# encoding: utf-8

namespace :metrics do
  begin
    require 'yardstick/rake/measurement'
    require 'yardstick/rake/verify'

    config = Devtools.project.yardstick

    # Enable the legacy parser for JRuby until ripper is fully supported
    if Devtools.jruby? && Devtools.ruby19?
      YARD::Parser::SourceParser.parser_type = :ruby18
    end

    # yardstick_measure task
    Yardstick::Rake::Measurement.new

    # verify_measurements task
    Yardstick::Rake::Verify.new do |verify|
      verify.threshold = config.threshold
    end
  rescue LoadError
    %w[ yardstick_measure verify_measurements ].each do |name|
      task name.to_s do
        $stderr.puts "Yardstick is not available. In order to run #{name}, you must: gem install yardstick"
      end
    end
  end
end
