require 'package'

class Crew_profile < Package
  description 'A profile for Chromebrew, to be used instead of ~/.*rc'
  homepage 'https://github.com/skycocker/chromebrew'
  version "2"
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  depends_on "xdg_base"

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc"
    FileUtils.mkdir_p CREW_DEST_HOME
    FileUtils.ln_s "#{HOME}/.profile", "#{CREW_DEST_PREFIX}/etc/profile"
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
