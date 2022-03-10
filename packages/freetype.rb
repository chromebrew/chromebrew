require 'package'

class Freetype < Package
  description 'FreeType is a freely available software library to render fonts.'
  homepage 'https://www.freetype.org/'
  version '2.11.1' # Update freetype in harfbuzz when updating freetype
  license 'FTL or GPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/freetype/freetype.git'
  git_hashtag "VER-#{version.tr('.', '-')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freetype/2.11.1_armv7l/freetype-2.11.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freetype/2.11.1_armv7l/freetype-2.11.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freetype/2.11.1_i686/freetype-2.11.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/freetype/2.11.1_x86_64/freetype-2.11.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5fb990e84010805de92eda4efac6b0cf183c8dee02eda7b2d1ed183028d0e857',
     armv7l: '5fb990e84010805de92eda4efac6b0cf183c8dee02eda7b2d1ed183028d0e857',
       i686: '2961cc77104f9a1eccd75905e957644ef1b21ef93fab368cbd1ed31c022dc43c',
     x86_64: '3c2492c222856b9a45bc8eaec55398f59e49062f8b3c9e45edc8b129d38c641b'
  })

  depends_on 'brotli'
  depends_on 'bz2'
  depends_on 'expat'
  depends_on 'gcc11'
  depends_on 'glib'
  depends_on 'graphite'
  depends_on 'harfbuzz'
  depends_on 'pcre'
  depends_on 'zlibpkg'
  # to avoid resetting mold usage
  no_env_options
  # This overwrites the freetype in harfbuzz, which have
  # epicircular dependencies on each other.
  conflicts_ok

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
    # make sure to delete downloaded files
    system "find #{CREW_BREW_DIR}/* -name freetype*.tar -exec rm -rf {} \+"
  end
end
