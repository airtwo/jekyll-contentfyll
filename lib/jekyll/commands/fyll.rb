require 'jekyll-contentfyll/importer'

module Jekyll
  # Module for Jekyll Commands
  module Commands
    # jekyll fyll Command
    class Fyll < Command
      def self.init_with_program(prog)
        prog.command(:fyll) do |c|
          c.syntax 'fyll [OPTIONS]'
          c.description 'Imports data from Contentful'

          options.each { |opt| c.option(*opt) }

          add_build_options(c)

          command_action(c)
        end
      end

      def self.options
        [
          [
            'rebuild', '-r', '--rebuild',
            'Rebuild Jekyll Site after fetching data'
          ]
        ]
      end

      def self.command_action(command)
        command.action do |args, options|
          jekyll_options = configuration_from_options(options)
          process args, options, jekyll_options
        end
      end

      def self.process(_args = [], options = {}, config = {})
        starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        Jekyll.logger.info '... Fylling Content ...'

        Jekyll::Contentfyll::Importer.new(config).run

        ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        elapsed = ending - starting
        Jekyll.logger.info '... Content Fylled ... '
        Jekyll.logger.info elapsed

        # return unless options['rebuild']

        # Jekyll.logger.info 'Starting Jekyll Rebuild'
        # Jekyll::Commands::Build.process(options)
      end
    end
  end
end