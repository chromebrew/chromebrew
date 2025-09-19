require 'package'

class Xdg_base < Package
  description 'XDG Base Directory Specification Configuration'
  homepage 'https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html'
  version '0.8'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b896793f7cee2da932f848289825d2e2eebd36d6217e158059a8a9e855130ff2',
     armv7l: 'b896793f7cee2da932f848289825d2e2eebd36d6217e158059a8a9e855130ff2',
       i686: 'd01f1293290fffaa7743331cc89a9e7bb61fc82e4753eb63ab88a505590c0787',
     x86_64: '41fe979913548d6cb8bd1bd9131ce063705f5c4be0aef451405426471ae80886'
  })

  no_source_build

  def self.preinstall
    # Save any previous configuration, if it exists.
    if File.directory?("#{HOME}/.config") && !File.symlink?("#{HOME}/.config") && !FileUtils.cp_r("#{HOME}/.config",
                                                                                                  "#{CREW_PREFIX}/")
      FileUtils.rm_rf("#{HOME}/.config")
    end
    if File.directory?("#{HOME}/.local") && !File.symlink?("#{HOME}/.local") && !FileUtils.cp_r("#{HOME}/.local/.",
                                                                                                "#{CREW_PREFIX}/.config/")
      FileUtils.rm_rf("#{HOME}/.local")
    end
  end

  def self.install
    File.write 'xdg_base', <<~XDGBASEEOF
      # Chromebrew's XDG configuration
      # See https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
      # XDG Base Directory Specification Environment Variables
      export XDG_CACHE_HOME=#{CREW_PREFIX}/.cache
      export XDG_CONFIG_DIRS=#{CREW_PREFIX}/etc/xdg
      export XDG_CONFIG_HOME=#{CREW_PREFIX}/.config
      export XDG_DATA_DIRS=#{CREW_PREFIX}/share
      export XDG_DATA_HOME=#{CREW_PREFIX}/.config/.local/share
      export XDG_RUNTIME_DIR=/var/run/chrome
      export XDG_STATE_HOME=#{CREW_PREFIX}/.config/.local/state
    XDGBASEEOF
    FileUtils.install 'xdg_base', "#{CREW_DEST_PREFIX}/etc/env.d/xdg_base", mode: 0o644
  end

  def self.postinstall
    FileUtils.mkdir_p "#{CREW_PREFIX}/.config/.local/share"
    FileUtils.mkdir_p "#{CREW_PREFIX}/.config/.local/state"
    FileUtils.mkdir_p "#{CREW_PREFIX}/.cache"
    FileUtils.mkdir_p "#{CREW_PREFIX}/etc/xdg"
  end
end
