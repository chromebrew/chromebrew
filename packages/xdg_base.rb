require 'package'

class Xdg_base < Package
  description 'XDG Base Directory Specification Configuration'
  homepage 'https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html'
  version '0.7-7'
  license 'GPL-3+'
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

  def self.install

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @env = <<~EOF
      # Chromebrew's XDG configuration
      # See https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
      # XDG Base Directory Specification Environment Variables
      export XDG_CACHE_HOME=#{CREW_PREFIX}/.cache
      export XDG_CONFIG_DIRS=#{CREW_PREFIX}/etc/xdg
      export XDG_CONFIG_HOME=#{CREW_PREFIX}/.config
      export XDG_DATA_DIRS=#{CREW_PREFIX}/share
      export XDG_DATA_HOME=#{CREW_PREFIX}/.config/.local/share
      export XDG_RUNTIME_DIR=/var/run/chrome
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/xdg_base", @env)
  end

  def self.postinstall
    FileUtils.mkdir_p "#{CREW_PREFIX}/.config/.local/share"
    FileUtils.mkdir_p "#{CREW_PREFIX}/.cache"
    FileUtils.mkdir_p "#{CREW_PREFIX}/etc/xdg"
  end
end
