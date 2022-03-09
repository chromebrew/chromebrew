require 'package'

class Freetype_sub < Package
  description 'Freetype_sub is a version without harfbuzz. It is intended to handle circular dependency betwwen freetype and harfbuzz.'
  homepage 'https://www.freetype.org/'
  version '2.11.1'
  license 'FTL or GPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/freetype/freetype.git'
  git_hashtag "VER-#{version.gsub('.', '-')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freetype_sub/2.11.1_armv7l/freetype_sub-2.11.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freetype_sub/2.11.1_armv7l/freetype_sub-2.11.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freetype_sub/2.11.1_i686/freetype_sub-2.11.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freetype_sub/2.11.1_x86_64/freetype_sub-2.11.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'dade3724751a8464424a46ba371709dc59cc2ffe77bc6ed3d8d33915509722cb',
     armv7l: 'dade3724751a8464424a46ba371709dc59cc2ffe77bc6ed3d8d33915509722cb',
       i686: 'd9a07e30d8916c0350f4153dd2237c9c813da5237666b06b5c2f5261c2d7138a',
     x86_64: 'a39929de0a9505e42d2631d8bea2a77cdb67b5ef61fbe83ed6a4192eb89192b5'
  })

  depends_on 'brotli'
  depends_on 'expat'
  depends_on 'libpng'  # freetype needs zlib optionally. zlib is also the dependency of libpng
  depends_on 'bz2'
  conflicts_ok
  no_env_options

  def self.build
    case ARCH
    when 'aarch64', 'armv7l'
      @meson_options = CREW_MESON_OPTIONS
    when 'i686', 'x86_64'
      @meson_options = CREW_MESON_OPTIONS.gsub('-Dc_args=\'-O2', '-Dc_args=\'-O2 -fuse-ld=mold').gsub('-Dcpp_args=\'-O2',
                                                                                                      '-Dcpp_args=\'-O2 -fuse-ld=mold')
    end
    system 'pip3 install docwriter'
    system "meson #{@meson_options} \
      -Dharfbuzz=disabled \
      builddir"
    system 'meson configure builddir'
    system 'samu -C builddir'
    system 'pip3 uninstall docwriter -y'
    system "pip3 install docwriter --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end

  def self.postinstall
    system "find #{CREW_BREW_DIR}/* -name freetype*.tar | xargs rm -rf"  # make sure to delete downloaded files
    @device = JSON.parse(File.read("#{CREW_CONFIG_PATH}device.json"), symbolize_names: true)
    if @device[:installed_packages].any? 'freetype'
      puts "Please reinstall freetype with 'crew reinstall freetype' as this installation may have broken freetype.".lightred
    end
  end

  def self.remove
    @device = JSON.parse(File.read("#{CREW_CONFIG_PATH}device.json"), symbolize_names: true)
    if @device[:installed_packages].any? 'freetype'
      puts "Please reinstall freetype with 'crew reinstall freetype' as this removal may have broken freetype.".lightred
    end
  end
end
