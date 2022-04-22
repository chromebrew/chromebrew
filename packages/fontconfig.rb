require 'package'

class Fontconfig < Package
  description 'Fontconfig is a library for configuring and customizing font access.'
  homepage 'https://www.freedesktop.org/software/fontconfig/front.html'
  @_ver = '2.14.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/fontconfig/fontconfig.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fontconfig/2.14.0_armv7l/fontconfig-2.14.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fontconfig/2.14.0_armv7l/fontconfig-2.14.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fontconfig/2.14.0_i686/fontconfig-2.14.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fontconfig/2.14.0_x86_64/fontconfig-2.14.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '73da87e4645d2fb31682be0d4d58ba7dfab33bf5e7eebb3725b64dac9bbe0482',
     armv7l: '73da87e4645d2fb31682be0d4d58ba7dfab33bf5e7eebb3725b64dac9bbe0482',
       i686: '47f744211b28c0a5f44ec9f02a629310dc8952607d7481fb2c7a96374b16e4ad',
     x86_64: 'bb28212f219e29c3bfd670189813e46f8d46ba79cd88259004dd4b6ad5f1f411'
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
