require 'package'

class Fontconfig < Package
  description 'Fontconfig is a library for configuring and customizing font access.'
  homepage 'https://www.freedesktop.org/software/fontconfig/front.html'
  @_ver = '2.14.0'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/fontconfig/fontconfig.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fontconfig/2.14.0-1_armv7l/fontconfig-2.14.0-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fontconfig/2.14.0-1_armv7l/fontconfig-2.14.0-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fontconfig/2.14.0-1_i686/fontconfig-2.14.0-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fontconfig/2.14.0-1_x86_64/fontconfig-2.14.0-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e84766cac7cbb4416041e49c9d668ee8b52a1689737f652be6b6eb5c17b652e3',
     armv7l: 'e84766cac7cbb4416041e49c9d668ee8b52a1689737f652be6b6eb5c17b652e3',
       i686: '4012be43038438529efd2ba423ce1a561c012d37fdc8c33bd03b6b702a5d86ad',
     x86_64: 'b2a370a40b5fd70213555c598663be865ed67f263fa9bcaa9c910f5394c87200'
  })

  depends_on 'gperf'
  depends_on 'jsonc'
  depends_on 'util_linux'
  depends_on 'graphite'
  no_fhs

  # Remove fontconfig before rebuilding this package.

  def self.build
    # Fix build failure from font directories not being writable.
    @install_cache = <<~INSTALLCACHE_HEREDOC
      #!/usr/bin/env python3
      import sys
      sys.exit()
    INSTALLCACHE_HEREDOC
    File.write('install-cache', @install_cache, perm: 0o666)
    system "meson #{CREW_MESON_OPTIONS} \
    --localstatedir=#{CREW_PREFIX}/cache \
    --default-library=both \
    -Ddoc=disabled \
    -Dfreetype2:harfbuzz=disabled \
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
    File.write("#{CREW_DEST_PREFIX}/etc/fonts/conf.d/52-chromebrew.conf", @fonts_conf, perm: 0o666)

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @env = <<~EOF
      # Fontconfig configuration
      export FONTCONFIG_PATH=#{CREW_PREFIX}/etc/fonts
    EOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/fontconfig", @env)
  end

  def self.preinstall
    @device = JSON.parse(File.read("#{CREW_CONFIG_PATH}device.json"), symbolize_names: true)
    if @device[:installed_packages].any? { |elem| elem[:name] == 'freetype' }
      system "sed -i '/freetype2/d;/libfreetype/d' filelist"
      system "sed -i '/freetype2/d;/libfreetype/d' dlist"
    end
  end

  def self.postinstall
    system "FONTCONFIG_PATH=#{CREW_PREFIX}/etc/fonts fc-cache -fv || true"
  end
end
