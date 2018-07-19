require 'package'

class Crew_profile < Package
  description 'A profile for Chromebrew, to be used instead of ~/.*rc'
  homepage 'https://github.com/skycocker/chromebrew'
  version '0.4.3'
  source_url 'https://raw.githubusercontent.com/skycocker/chromebrew/master/install.sh'
  source_sha256 '6c061009df229624485279e8a076f94b61218b8dc67478d49a6b563692e92aef'

  def self.postinstall
    puts
    puts "To create your very own Crew profile, please execute this:".lightblue
    puts
    puts "echo \"if [ -f #{CREW_PREFIX}/etc/profile ]; then\" >> ~/.\{bash,zsh\}rc".lightblue
    puts "echo \"  # Source crew profile\" >> ~/.\{bash,zsh\}rc".lightblue
    puts "echo \"  source #{CREW_PREFIX}/etc/profile\" >> ~/.\{bash,zsh\}rc".lightblue
    puts "echo \"fi\" >> ~/.\{bash,zsh\}rc".lightblue
    puts "source ~/.\{bash,zsh\}rc"
    puts
    puts "Works with Bash and Zsh"
    puts
  end
end
