require 'package'

class Crew_profile < Package
  description 'A profile for Chromebrew, to be used instead of ~/.*rc'
  homepage 'https://github.com/skycocker/chromebrew'
  version '0.4.3'
  source_url 'https://github.com/skycocker/chromebrew/raw/511ee9cb3138e113df74ddf0dee057ef5d9a46fd/README.md'
  source_sha256 '27b201cec82d903a1856972e6d7ff1ac58a67c761d729ecd7fd14f24fa9d9901'

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
