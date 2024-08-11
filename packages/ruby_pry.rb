require 'buildsystems/ruby'
require 'highline/import'

class Ruby_pry < RUBY
  description 'Pry is a runtime developer console and IRB alternative with powerful introspection capabilities.'
  homepage 'https://github.com/pry/pry'
  version '0.14.2-ruby-3.3'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed

  def self.postinstall
    File.write "#{HOME}/.pryrc", <<~PRY_DEBUG_EOF
      if defined?(PryByebug)
        Pry.commands.alias_command 'c', 'continue'
        Pry.commands.alias_command 's', 'step'
        Pry.commands.alias_command 'n', 'next'
        Pry.commands.alias_command 'f', 'finish'
      end
      # Hit Enter to repeat last command
      Pry::Commands.command /^$/, "repeat last command" do
        pry_instance.run_command Pry.history.to_a.last
      end
    PRY_DEBUG_EOF
  end

  def self.remove
    config_file = "#{HOME}/.pryrc"
    if File.file? config_file
      if agree("Would you like to remove the #{name} config file: #{config_file}? ")
        FileUtils.rm_rf config_file
        puts "#{config_file} removed.".lightgreen
      else
        puts "#{config_file} saved.".lightgreen
      end
    end
  end
end
