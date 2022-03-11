require 'package'

class Fontconfig < Package
  description 'Fontconfig is a library for configuring and customizing font access.'
  homepage 'https://www.freedesktop.org/software/fontconfig/front.html'
  @_ver = '2.13.96'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/fontconfig/fontconfig.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fontconfig/2.13.96_armv7l/fontconfig-2.13.96-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fontconfig/2.13.96_armv7l/fontconfig-2.13.96-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fontconfig/2.13.96_i686/fontconfig-2.13.96-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fontconfig/2.13.96_x86_64/fontconfig-2.13.96-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ee7900160a576c6402191b39c4a1764691d1eb97f18c19e0117bf2fd9fc0435c',
     armv7l: 'ee7900160a576c6402191b39c4a1764691d1eb97f18c19e0117bf2fd9fc0435c',
       i686: '5dc551362bc72fdcbd7734812e62d5035a97fee9b733b6690cae2286e6d4d69d',
     x86_64: '0c0f777ba5352f92851c70a010b25824fa269dab2b389b95f823e03d890f4b15'
  })

  depends_on 'gperf'
  depends_on 'harfbuzz' => :build
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
    File.write("#{CREW_DEST_PREFIX}/etc/fonts/conf.d/52-chromebrew.conf", @fonts_conf, perm: 0o666)

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @env = <<~EOF
      # Fontconfig configuration
      export FONTCONFIG_PATH=#{CREW_PREFIX}/etc/fonts
    EOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/fontconfig", @env)
  end

  def self.postinstall
    # The following postinstall fails if graphite isn't installed when fontconfig
    # is being installed.
    system "env FONTCONFIG_PATH=#{CREW_PREFIX}/etc/fonts fc-cache -fv || true"
  end
end
