# encoding: utf-8

namespace :metrics do
  desc 'Run rubocop'
  task :rubocop do
    require 'rubocop'
    config = Devtools.project.rubocop
    begin
      Rubocop::CLI.new.run(%W[--config #{config.config_file.to_s} --debug])
    rescue Encoding::CompatibilityError => exception
      $stderr.puts exception.message
    end
  end
end
