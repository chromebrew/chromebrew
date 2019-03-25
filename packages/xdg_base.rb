require 'package'

class Xdg_base < Package
  description 'XDG Base Directory Specification Configuration'
  homepage 'https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html'
  version '0.7-4'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  def self.preinstall
    # Save any previous configuration, if it exists.
    if Dir.exists? "#{HOME}/.config"
      if File.readlink("#{HOME}/.config") != "#{CREW_PREFIX}/.config"
        puts('File.readlink("#{HOME}/.config") != "#{CREW_PREFIX}/.config"') # Debug message
        if !FileUtils.cp_r("#{HOME}/.config", "#{CREW_PREFIX}/")
          puts('FileUtils.cp_r("#{HOME}/.config", "#{CREW_PREFIX}/")') # Debug
          FileUtils.rm_rf("#{HOME}/.config")
        end
      end
    end
    if Dir.exists? "#{HOME}/.local"
      puts('Dir.exists? "#{HOME}/.local"') # Debug
      FileUtils.mkdir_p("#{CREW_PREFIX}/.config") unless Dir.exists? "#{CREW_PREFIX}/.config"
      if File.readlink("#{HOME}/.local") != "#{CREW_PREFIX}/.config"
        puts('File.readlink("#{HOME}/.local") != "#{CREW_PREFIX}/.config"') # Debug
        if !FileUtils.cp_r("#{HOME}/.local/.", "#{CREW_PREFIX}/.config/")
          puts('FileUtils.cp_r("#{HOME}/.local/.", "#{CREW_PREFIX}/.config/")') # Debug
          FileUtils.rm_rf("#{HOME}/.local") 
        end
      end
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
    puts 'The following environment variables should be set as shown below:'.lightblue
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
