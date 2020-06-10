require 'package'

class Crew_profile < Package
  description 'A profile for Chromebrew, to be used instead of ~/.*rc'
  homepage 'https://github.com/skycocker/chromebrew'
  version "1"
  compatibility 'all'
  source_url 'https://github.com/skycocker/chromebrew/raw/511ee9cb3138e113df74ddf0dee057ef5d9a46fd/README.md'
  source_sha256 '27b201cec82d903a1856972e6d7ff1ac58a67c761d729ecd7fd14f24fa9d9901'

  depends_on "xdg_base"

  def self.install
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/etc"
    system "mkdir", "-p", "#{CREW_DEST_HOME}"
    system "ln", "-s", "#{ENV['HOME']}/.profile", "#{CREW_DEST_PREFIX}/etc/profile"
  end

  def self.postinstall
    puts
    puts "Works with Bash, Zsh, and Fish".lightblue
    puts
    puts "To create your very own Crew profile, please execute this:".lightblue
    puts
    puts "touch ~/.profile".lightblue
    puts
    puts "For Bash, execute this:".lightblue
    puts
    puts "echo \"if [ -f #{CREW_PREFIX}/etc/profile ]; then\" >> ~/.bashrc".lightblue
    puts "echo \"  # Source crew profile\" >> ~/.bashrc".lightblue
    puts "echo \"  source #{CREW_PREFIX}/etc/profile\" >> ~/.bashrc".lightblue
    puts "echo \"fi\" >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
    puts "For Zsh, execute this:".lightblue
    puts
    puts "echo \"if [ -f #{CREW_PREFIX}/etc/profile ]; then\" >> ~/.zshrc".lightblue
    puts "echo \"  # Source crew profile\" >> ~/.zshrc".lightblue
    puts "echo \"  source #{CREW_PREFIX}/etc/profile\" >> ~/.zshrc".lightblue
    puts "echo \"fi\" >> ~/.zshrc".lightblue
    puts "source ~/.zshrc".lightblue
    puts
    puts "For Fish, execute this:".lightblue
    puts
    puts "echo \"if [ -f #{CREW_PREFIX}/etc/profile ]\" >> ~/.config/fish/config.fish".lightblue
    puts "echo \"  # Source crew profile\" >> ~/.config/fish/config.fish".lightblue
    puts "echo \"  source #{CREW_PREFIX}/etc/profile\" >> ~/.config/fish/config.fish".lightblue
    puts "echo \"end\" >> ~/.config/fish/config.fish".lightblue
    puts "source ~/.config/fish/config.fish".lightblue
    puts
  end
end
