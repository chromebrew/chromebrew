require 'package'

class Fontconfig < Package
  description 'Fontconfig is a library for configuring and customizing font access.'
  homepage 'https://www.freedesktop.org/software/fontconfig/front.html'
  @_ver = '2.13.94'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url "https://github.com/freedesktop/fontconfig/archive/#{@_ver}.tar.gz"
  source_sha256 '4cfaf426a59ad65ea7397182156efdc01835bab9a8e81d15e008f08d38f38d58'

  binary_url({
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fontconfig/2.13.94_i686/fontconfig-2.13.94-chromeos-i686.tpxz',
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fontconfig/2.13.94_armv7l/fontconfig-2.13.94-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fontconfig/2.13.94_armv7l/fontconfig-2.13.94-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fontconfig/2.13.94_x86_64/fontconfig-2.13.94-chromeos-x86_64.tpxz'
  })
  binary_sha256({
       i686: '63bfecf60d42174392ba22d0762f0fb6102540d784eaa86cd098a411e7349d8d',
    aarch64: '85980c50415f61219e04efc1bb7ae977083756bccb65f7dbe5d6bfc7562698a6',
     armv7l: '85980c50415f61219e04efc1bb7ae977083756bccb65f7dbe5d6bfc7562698a6',
     x86_64: '00e921605653191b9b62fadf1437834211e11436c685660782fc1641bd20bfbe'
  })

  depends_on 'gperf'
  depends_on 'freetype_sub'
  depends_on 'jsonc'
  depends_on 'util_linux'
  depends_on 'graphite'

  # Remove freetype and fontconfig before rebuilding this package.

  def self.build
    # Fix build failure from font directories not being writable.
    @install_cache = <<~INSTALLCACHE_HEREDOC
      #!/usr/bin/env python3
      import sys
      sys.exit()
    INSTALLCACHE_HEREDOC
    IO.write('install-cache', @install_cache, perm: 0o666)
    system "meson #{CREW_MESON_OPTIONS} \
    --localstatedir=#{CREW_PREFIX}/var \
    --default-library=both \
    -Ddoc=disabled \
    -Dfreetype2:harfbuzz=enabled \
    -Dfreetype2:default_library=both \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/fonts/conf.d"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/var/cache/fontconfig"
    @fonts_conf = <<~FONTCONF_HEREDOC
      <?xml version="1.0"?>
      <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
      <fontconfig>
        <description>Load local customization file</description>
        <!-- Font directory list -->
        <dir>/usr/local/share/fonts</dir>
        <dir>~/.fonts</dir>
        <!-- Font cache directory list -->
        <cachedir>#{CREW_PREFIX}/var/cache/fontconfig</cachedir>
        <cachedir>~/.fontconfig</cachedir>
      </fontconfig>
    FONTCONF_HEREDOC
    IO.write("#{CREW_DEST_PREFIX}/etc/fonts/conf.d/52-chromebrew.conf", @fonts_conf, perm: 0o666)

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @env = <<~FONTCONFIG_ENV_HEREDOC
      # Fontconfig configuration
      export FONTCONFIG_PATH=#{CREW_PREFIX}/etc/fonts
    FONTCONFIG_ENV_HEREDOC
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/fontconfig", @env)
  end

  def self.postinstall
    # The following postinstall fails if graphite isn't installed when fontconfig
    # is being installed.
    system "env FONTCONFIG_PATH=#{CREW_PREFIX}/etc/fonts fc-cache -fv || true"
  end
end
