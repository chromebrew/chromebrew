require 'package'

class Xdg_base < Package
  description 'XDG Base Directory Specification Configuration'
  homepage 'https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html'
  version '0.7'
  source_url 'https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html'
  source_sha256 '342289ad33b48b8f643278f74cafa182f4471d490b82dc5e442e2e720fa4080f'

  def self.install
    # Changes the ~/.config and ~/.local directories to use symlinks instead.
    # This is needed in cases when executables are installed in these locations.
    system "mkdir -p #{CREW_DEST_DIR}$HOME"
    system "mkdir -p #{CREW_DEST_PREFIX}/.config"
    system "mkdir -p #{CREW_DEST_PREFIX}/.local"
    system "ln -s #{CREW_PREFIX}/.config #{CREW_DEST_DIR}$HOME/.config"
    system "ln -s #{CREW_PREFIX}/.local #{CREW_DEST_DIR}$HOME/.local"
    system "ln -s #{CREW_PREFIX}/.config $HOME/.config"
    system "ln -s #{CREW_PREFIX}/.config $HOME/.local"
  end

  def self.postinstall
    puts
    puts "The following bash environment variables should set as shown below:".lightblue
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
