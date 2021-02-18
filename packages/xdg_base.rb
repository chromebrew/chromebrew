require 'package'

class Xdg_base < Package
  description 'XDG Base Directory Specification Configuration'
  homepage 'https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html'
  version '0.7-6'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  def self.preinstall
    # Save any previous configuration, if it exists.
    if File.directory?("#{HOME}/.config") && !File.symlink?("#{HOME}/.config")
      FileUtils.rm_rf("#{HOME}/.config") unless FileUtils.cp_r("#{HOME}/.config", "#{CREW_PREFIX}/")
    end
    if File.directory?("#{HOME}/.local") && !File.symlink?("#{HOME}/.local")
      FileUtils.mkdir_p("#{CREW_PREFIX}/.config") unless Dir.exists? "#{CREW_PREFIX}/.config"
      FileUtils.rm_rf("#{HOME}/.local") unless FileUtils.cp_r("#{HOME}/.local/.", "#{CREW_PREFIX}/.config/")
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
    xdgconfig_in_bashrc = `grep -c "XDG_CONFIG_HOME" ~/.bashrc || true`
    unless xdgconfig_in_bashrc.to_i.positive?
      puts 'Putting XDG Environment Variables in ~/.bashrc'.lightblue
      system "echo '# XDG Base Directory Specification Environment Variables' >> ~/.bashrc"
      system "echo '# See https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html' >> ~/.bashrc"
      system "echo 'export XDG_DATA_HOME=#{HOME}/.local/share' >> ~/.bashrc"
      system "echo 'export XDG_CONFIG_HOME=#{HOME}/.config' >> ~/.bashrc"
      system "echo 'export XDG_DATA_DIRS=#{CREW_PREFIX}/share' >> ~/.bashrc"
      system "echo 'export XDG_CONFIG_DIRS=#{CREW_PREFIX}/etc/xdg' >> ~/.bashrc"
      system "echo 'export XDG_CACHE_HOME=#{HOME}/.cache' >> ~/.bashrc"
      system "echo 'export XDG_RUNTIME_DIR=/var/run/chrome' >> ~/.bashrc"
      puts 'To complete the installation, execute the following:'.orange
      puts 'source ~/.bashrc'.orange
    end
   end
end
