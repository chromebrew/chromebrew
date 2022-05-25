require 'package'

class Xdg_base < Package
  description 'XDG Base Directory Specification Configuration'
  homepage 'https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html'
  version '0.7-7-1'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xdg_base/0.7-7-1_armv7l/xdg_base-0.7-7-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xdg_base/0.7-7-1_armv7l/xdg_base-0.7-7-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xdg_base/0.7-7-1_i686/xdg_base-0.7-7-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xdg_base/0.7-7-1_x86_64/xdg_base-0.7-7-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '2ec80e4af5d9791083b8004542b4fda18160a8773ef42a7390ec3018927c37ea',
     armv7l: '2ec80e4af5d9791083b8004542b4fda18160a8773ef42a7390ec3018927c37ea',
       i686: '34df15da8d205ac30a6a439829851502676e9f3484d1c823cdffb65eeba91327',
     x86_64: '6e8adac27ccf434f6e4c227487cc6d0ab262093c34095170ec351537a003981b'
  })

  def self.preinstall
    # Save any previous configuration, if it exists.
    if File.directory?("#{HOME}/.config") && !File.symlink?("#{HOME}/.config") && !FileUtils.cp_r("#{HOME}/.config",
                                                                                                  "#{CREW_PREFIX}/")
      FileUtils.rm_rf("#{HOME}/.config")
    end
    if File.directory?("#{HOME}/.local") && !File.symlink?("#{HOME}/.local") && !FileUtils.cp_r("#{HOME}/.local/.",
                                                                                                "#{CREW_PREFIX}/.config/")
      # FileUtils.mkdir_p("#{CREW_PREFIX}/.config") unless Dir.exist? "#{CREW_PREFIX}/.config"
      FileUtils.rm_rf("#{HOME}/.local")
    end
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @xdgbaseenv = <<~XDGBASEEOF
      # Chromebrew's XDG configuration
      # See https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
      # XDG Base Directory Specification Environment Variables
      export XDG_CACHE_HOME=#{CREW_PREFIX}/.cache
      export XDG_CONFIG_DIRS=#{CREW_PREFIX}/etc/xdg
      export XDG_CONFIG_HOME=#{CREW_PREFIX}/.config
      export XDG_DATA_DIRS=#{CREW_PREFIX}/share
      export XDG_DATA_HOME=#{CREW_PREFIX}/.config/.local/share
      export XDG_RUNTIME_DIR=/var/run/chrome
    XDGBASEEOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/xdg_base", @xdgbaseenv)
  end

  def self.postinstall
    FileUtils.mkdir_p "#{CREW_PREFIX}/.config/.local/share"
    FileUtils.mkdir_p "#{CREW_PREFIX}/.cache"
    FileUtils.mkdir_p "#{CREW_PREFIX}/etc/xdg"
  end
end
