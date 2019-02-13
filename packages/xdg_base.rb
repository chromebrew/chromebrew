require 'package'

class Xdg_base < Package
  description 'XDG Base Directory Specification Configuration'
  homepage 'https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html'
  version '0.7-3'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  def self.preinstall
    # Save any previous configuration, if it exists.
    if Dir.exists? "#{HOME}/.config"
      FileUtils.cp_r("#{HOME}/.config", "#{CREW_PREFIX}/")
      FileUtils.rm_rf("#{HOME}/.config")
    end
    if Dir.exists? "#{HOME}/.local"
      FileUtils.mkdir_p("#{CREW_PREFIX}/.config") unless Dir.exists? "#{CREW_PREFIX}/.config"
      FileUtils.cp_r("#{HOME}/.local/.", "#{CREW_PREFIX}/.config/")
      FileUtils.rm_rf("#{HOME}/.local")
    end
  end

  def self.install
    # Changes the ~/.config and ~/.local directories to use symlinks instead.
    # This is needed in cases when executables are installed in these locations.
    FileUtils.mkdir_p(CREW_DEST_HOME)
    FileUtils.mkdir_p(CREW_DEST_PREFIX + '/.config')
    FileUtils.ln_s(CREW_PREFIX + '/.config', CREW_DEST_HOME + '/.config')
    FileUtils.ln_s(CREW_PREFIX + '/.config', CREW_DEST_HOME + '/.local')
  end

  def self.postinstall
    puts
    puts 'The following bash environment variables should be set as shown below:'.lightblue
    puts
    puts "echo '# XDG Base Directory Specification Environment Variables' >> ~/.bashrc".lightblue
    puts "echo '# See https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html' >> ~/.bashrc".lightblue
    puts "echo 'export XDG_DATA_HOME=#{HOME}/.local/share' >> ~/.bashrc".lightblue
    puts "echo 'export XDG_CONFIG_HOME=#{HOME}/.config' >> ~/.bashrc".lightblue
    puts "echo 'export XDG_DATA_DIRS=#{CREW_PREFIX}/share' >> ~/.bashrc".lightblue
    puts "echo 'export XDG_CONFIG_DIRS=#{CREW_PREFIX}/etc/xdg' >> ~/.bashrc".lightblue
    puts "echo 'export XDG_CACHE_HOME=#{HOME}/.cache' >> ~/.bashrc".lightblue
    puts "echo 'export XDG_RUNTIME_DIR=/var/run/chrome' >> ~/.bashrc".lightblue
    puts 'source ~/.bashrc'.lightblue
    puts
  end
end
