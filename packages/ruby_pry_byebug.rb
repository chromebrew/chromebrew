require 'buildsystems/ruby'

class Ruby_pry_byebug < RUBY
  description 'Adds step-by-step debugging and stack navigation capabilities to pry using byebug.'
  homepage 'https://github.com/deivid-rodriguez/pry-byebug'
  version '3.10.1-ruby-3.3'
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
      print "Would you like to remove the #{name} config file: #{config_file}? [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        FileUtils.rm_rf config_file
        puts "#{config_file} removed.".lightgreen
      else
        puts "#{config_file} saved.".lightgreen
      end
    end
  end
end
