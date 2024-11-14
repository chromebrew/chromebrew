require 'buildsystems/ruby'

class Ruby_pry < RUBY
  description 'Pry is a runtime developer console and IRB alternative with powerful introspection capabilities.'
  homepage 'https://github.com/pry/pry'
  version "0.14.2-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed

  ruby_install_extras do
    File.write File.join(HOME, '.pryrc'), <<~PRY_DEBUG_EOF
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

  def self.postremove
    Package.agree_to_remove("#{HOME}/.pryrc")
  end
end
