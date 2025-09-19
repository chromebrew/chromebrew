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
    aarch64: '732748fcdc3667c4325136a0fff23eff880996e5b3a2161b51782243c10547ea',
     armv7l: '732748fcdc3667c4325136a0fff23eff880996e5b3a2161b51782243c10547ea',
       i686: '50372f2b3b0a72b5297e4e9e2635297850c9924e6e3cfb89ae1bcf9a6828bf83',
     x86_64: 'aa41edb071a49e784fff9aa4b1bea1de3fa370d422c7a686bc5a10c158646b0a'
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
    @xdgbaseenv = <<~XDGBASEEOF
      # Chromebrew's XDG configuration
      # See https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
      # XDG Base Directory Specification Environment Variables
      export XDG_CACHE_HOME=#{CREW_PREFIX}/.cache
      export XDG_CONFIG_DIRS=#{CREW_PREFIX}/etc/xdg
      export XDG_CONFIG_HOME=#{CREW_PREFIX}/.config
      export XDG_DATA_DIRS=#{CREW_PREFIX}/share
      export XDG_DATA_HOME=#{CREW_PREFIX}/.config/.local/share
      export XDG_STATE_HOME=#{CREW_PREFIX}/.config/.local/state
      export XDG_RUNTIME_DIR=/var/run/chrome
    XDGBASEEOF
    File.write('xdg_base', @xdgbaseenv)
    FileUtils.install 'xdg_base', "#{CREW_DEST_PREFIX}/etc/env.d/xdg_base", mode: 0o644
  end

  def self.postinstall
    FileUtils.mkdir_p "#{CREW_PREFIX}/.config/.local/share"
    FileUtils.mkdir_p "#{CREW_PREFIX}/.config/.local/state"
    FileUtils.mkdir_p "#{CREW_PREFIX}/.cache"
    FileUtils.mkdir_p "#{CREW_PREFIX}/etc/xdg"
  end
end
