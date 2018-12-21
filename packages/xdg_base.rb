require 'package'

class Xdg_base < Package
  description 'XDG Base Directory Specification Configuration'
  homepage 'https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html'
  version '0.7-2'
  source_url 'https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html'
  source_sha256 '342289ad33b48b8f643278f74cafa182f4471d490b82dc5e442e2e720fa4080f'

  def self.preinstall
    # Save any previous configuration, if it exists.
    if Dir.exists? "$HOME/.config"
      system "cp -a $HOME/.config #{CREW_PREFIX} && rm -rf $HOME/.config"
    end
    if Dir.exists? "$HOME/.local"
      system "mkdir -p #{CREW_PREFIX}/.config" unless Dir.exists? "#{CREW_PREFIX}/.config"
      system "cp -a $HOME/.local/. #{CREW_PREFIX}/.config && rm -rf $HOME/.local"
    end
  end

  def self.install
    # Changes the ~/.config and ~/.local directories to use symlinks instead.
    # This is needed in cases when executables are installed in these locations.
    system "mkdir -p #{CREW_DEST_HOME}"
    system "mkdir -p #{CREW_DEST_PREFIX}/.config"
    system "ln -s #{CREW_PREFIX}/.config #{CREW_DEST_HOME}/.config"
    system "ln -s #{CREW_PREFIX}/.config #{CREW_DEST_HOME}/.local"
  end

  def self.postinstall
    puts
    puts "The following bash environment variables should be set as shown below:".lightblue
    puts "echo '# XDG Base Directory Specification Environment Variables' >> ~/.bashrc".lightblue
    puts "echo '# See https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html.' >> ~/.bashrc".lightblue
    puts "echo 'export XDG_DATA_HOME=\$HOME/.local/share' >> ~/.bashrc".lightblue
    puts "echo 'export XDG_CONFIG_HOME=\$HOME/.config' >> ~/.bashrc".lightblue
    puts "echo 'export XDG_DATA_DIRS=#{CREW_PREFIX}/share' >> ~/.bashrc".lightblue
    puts "echo 'export XDG_CONFIG_DIRS=#{CREW_PREFIX}/etc/xdg' >> ~/.bashrc".lightblue
    puts "echo 'export XDG_CACHE_HOME=\$HOME/.cache' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
  end
end
