require 'package'

class Fontconfig < Package
  description 'Fontconfig is a library for configuring and customizing font access.'
  homepage 'https://www.freedesktop.org/software/fontconfig/front.html'
  @_ver = '2.13.93'
  version "#{@_ver}-1"
  compatibility 'all'
  source_url "https://github.com/freedesktop/fontconfig/archive/#{@_ver}.tar.gz"
  source_sha256 'f8452c78d1a12f6966455b0d584f89553b13e970b40644c3650f690ec0b3b4fe'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fontconfig-2.13.93-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fontconfig-2.13.93-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fontconfig-2.13.93-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fontconfig-2.13.93-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'fac3629221d8a54bba8a1a8e1fc151706a434320c2a92726508234c799cecade',
     armv7l: 'fac3629221d8a54bba8a1a8e1fc151706a434320c2a92726508234c799cecade',
       i686: '668b4e389a105b91ed6b75416cea01e84856eaa8d7902448c9907670e1acf13b',
     x86_64: 'd38e7415b0dad534c2bdfc66a8460c6a5ba00153dade7033e757ffd8be8ea30a'
  })

  depends_on 'gperf'
  depends_on 'freetype_sub'
  depends_on 'jsonc'
  depends_on 'util_linux'
  depends_on 'graphite' => :build

  # Remove freetype and fontconfig before rebuilding this package.

  def self.build
    # Fix build failure from font directories not being writable.
    @install_cache = <<~INSTALLCACHE_HEREDOC
      #!/usr/bin/env python3
      import sys
      sys.exit()
    INSTALLCACHE_HEREDOC
    IO.write('install-cache', @install_cache, perm: 0o666)
    system "meson #{CREW_MESON_LTO_OPTIONS} \
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
  end

  def self.postinstall
    fontconfig_in_bashrc = `grep -c "FONTCONFIG_PATH" ~/.bashrc || true`
    unless fontconfig_in_bashrc.to_i.positive?
      puts 'Putting fontconfig code in ~/.bashrc'.lightblue
      system "echo 'export FONTCONFIG_PATH=#{CREW_PREFIX}/etc/fonts' >> ~/.bashrc"
      puts 'To complete the installation, execute the following:'.orange
      puts 'source ~/.bashrc'.orange
    end
    system "env FONTCONFIG_PATH=#{CREW_PREFIX}/etc/fonts fc-cache -fv"
  end
end
