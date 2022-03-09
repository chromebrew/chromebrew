require 'package'

class Freetype < Package
  description 'FreeType is a freely available software library to render fonts.'
  homepage 'https://www.freetype.org/'
  version '2.11.1'
  license 'FTL or GPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/freetype/freetype.git'
  git_hashtag "VER-#{version.gsub('.', '-')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freetype/2.11.1_armv7l/freetype-2.11.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freetype/2.11.1_armv7l/freetype-2.11.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freetype/2.11.1_i686/freetype-2.11.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freetype/2.11.1_x86_64/freetype-2.11.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4c91e5b7cb45c37c7ee444a2cd182e303d5e287727e04facdebecf7071464b78',
     armv7l: '4c91e5b7cb45c37c7ee444a2cd182e303d5e287727e04facdebecf7071464b78',
       i686: '20a3049b57dc11db42c30c722ddfa6036845787daecd2c0841160f5a845e652c',
     x86_64: 'b7fdf58d7b78165226c18223f6c3585cbb14f64212b372f8c352dbbe2a235144'
  })

  depends_on 'brotli'
  depends_on 'expat'
  depends_on 'libpng'  # freetype needs zlib optionally. zlib is also the dependency of libpng
  depends_on 'bz2'
  depends_on 'harfbuzz'
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
      -Dharfbuzz=enabled \
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
  end
end
