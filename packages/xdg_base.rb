require 'package'

class Xdg_base < Package
  description 'XDG Base Directory Specification Configuration'
  homepage 'https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html'
  version '0.7-7'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  def self.preinstall
    # Save any previous configuration, if it exists.
    if File.directory?("#{HOME}/.config") && !File.symlink?("#{HOME}/.config") && !FileUtils.cp_r("#{HOME}/.config",
                                                                                                  "#{CREW_PREFIX}/")
      FileUtils.rm_rf("#{HOME}/.config")
    end
    if File.directory?("#{HOME}/.local") && !File.symlink?("#{HOME}/.local") && !FileUtils.cp_r("#{HOME}/.local/.",
                                                                                                "#{CREW_PREFIX}/.config/")
      # FileUtils.mkdir_p("#{CREW_PREFIX}/.config") unless Dir.exists? "#{CREW_PREFIX}/.config"
      FileUtils.rm_rf("#{HOME}/.local")
    end
  end

  def self.postinstall
    FileUtils.mkdir_p "#{CREW_PREFIX}/.config/.local/share"
    FileUtils.mkdir_p "#{CREW_PREFIX}/.cache"
    FileUtils.mkdir_p "#{CREW_PREFIX}/etc/xdg"
    @_str = "XDG_CONFIG_HOME=#{CREW_PREFIX}/.config"
    if `grep -c '#{@_str}' #{HOME}/.bashrc`.to_i.zero?
      puts 'Putting XDG Environment Variables in ~/.bashrc'.lightblue
      system "echo '# See https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html' >> ~/.bashrc"
      system "echo '# XDG Base Directory Specification Environment Variables' >> ~/.bashrc"
      system "sed -i '/XDG_CACHE_HOME=/d' ~/.bashrc"
      system "sed -i '/XDG_CONFIG_DIRS/d' ~/.bashrc"
      system "sed -i '/XDG_CONFIG_HOME/d' ~/.bashrc"
      system "sed -i '/XDG_DATA_DIRS/d' ~/.bashrc"
      system "sed -i '/XDG_DATA_HOME/d' ~/.bashrc"
      system "sed -i '/XDG_RUNTIME_DIR/d' ~/.bashrc"
      system "echo 'export XDG_CACHE_HOME=#{CREW_PREFIX}/.cache' >> ~/.bashrc"
      system "echo 'export XDG_CONFIG_DIRS=#{CREW_PREFIX}/etc/xdg' >> ~/.bashrc"
      system "echo 'export XDG_CONFIG_HOME=#{CREW_PREFIX}/.config' >> ~/.bashrc"
      system "echo 'export XDG_DATA_DIRS=#{CREW_PREFIX}/share' >> ~/.bashrc"
      system "echo 'export XDG_DATA_HOME=#{CREW_PREFIX}/.config/.local/share' >> ~/.bashrc"
      system "echo 'export XDG_RUNTIME_DIR=/var/run/chrome' >> ~/.bashrc"
      puts 'To complete the installation, execute the following:'.orange
      puts 'source ~/.bashrc'.orange
      puts 'or reboot'.red
    end
  end
end
