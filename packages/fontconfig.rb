require 'package'

class Fontconfig < Package
  description 'Fontconfig is a library for configuring and customizing font access.'
  homepage 'https://www.freedesktop.org/software/fontconfig/front.html'
  @_ver = '2.13.93'
  version "#{@_ver}-2"
  license 'MIT'
  compatibility 'all'
  source_url "https://github.com/freedesktop/fontconfig/archive/#{@_ver}.tar.gz"
  source_sha256 'f8452c78d1a12f6966455b0d584f89553b13e970b40644c3650f690ec0b3b4fe'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/fontconfig-2.13.93-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/fontconfig-2.13.93-2-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/fontconfig-2.13.93-2-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/fontconfig-2.13.93-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '0047a707a1fc8531fa6bfc6fa45f2aead43ece0e65d1eaad094e4e98f3e43ec0',
     armv7l: '0047a707a1fc8531fa6bfc6fa45f2aead43ece0e65d1eaad094e4e98f3e43ec0',
       i686: 'abef1aab53d6880c0f43fc188a6de1ca1bf9b60c20c3f6459cdbcb40b32cb80a',
     x86_64: '762b2f4a1d0d593f7f4c5000b651e9d03e98b11759a113bac0c260cc45830391'
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
    --localstatedir=#{CREW_PREFIX}/cache \
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
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/cache/fontconfig"
    @fonts_conf = <<~FONTCONF_HEREDOC
      <?xml version="1.0"?>
      <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
      <fontconfig>
        <description>Load local customization file</description>
        <!-- Font directory list -->
        <dir>/usr/local/share/fonts</dir>
        <dir>~/.fonts</dir>
        <!-- Font cache directory list -->
        <cachedir>#{CREW_PREFIX}/cache/fontconfig</cachedir>
        <cachedir>~/.fontconfig</cachedir>
      </fontconfig>
    FONTCONF_HEREDOC
    IO.write("#{CREW_DEST_PREFIX}/etc/fonts/conf.d/52-chromebrew.conf", @fonts_conf, perm: 0o666)

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @env = <<~EOF
      # Fontconfig configuration
      export FONTCONFIG_PATH=#{CREW_PREFIX}/etc/fonts
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/fontconfig", @env)
  end

  def self.postinstall
    # The following postinstall fails if graphite isn't installed when fontconfig
    # is being installed.
    system "env FONTCONFIG_PATH=#{CREW_PREFIX}/etc/fonts fc-cache -fv || true"
  end
end
