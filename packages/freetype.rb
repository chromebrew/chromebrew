require 'package'

class Freetype < Package
  description 'FreeType is a freely available software library to render fonts.'
  homepage 'https://www.freetype.org/'
  version '2.11.1' # Update freetype in harfbuzz when updating freetype
  license 'FTL or GPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/freetype/freetype.git'
  git_hashtag "VER-#{version.tr('.', '-')}"

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
