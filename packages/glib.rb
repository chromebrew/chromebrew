require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  @_ver = '2.74.1'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.74.1_armv7l/glib-2.74.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.74.1_armv7l/glib-2.74.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.74.1_i686/glib-2.74.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.74.1_x86_64/glib-2.74.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4793afd0f2cd2d168d52a112f18de001d7e308383937e18ec177b3751a7da3ab',
     armv7l: '4793afd0f2cd2d168d52a112f18de001d7e308383937e18ec177b3751a7da3ab',
       i686: 'c7a5a227d4744079333d6597297acab9fa4ce30cbb4341744b49a805a4655ae5',
     x86_64: '67515679d697eb29fdff6ffff1392569636adcb6d51c542f56ddf02ce02c62d5'
  })

  depends_on 'elfutils' # R
  depends_on 'libffi' # R
  depends_on 'pcre' # R
  depends_on 'py3_pygments' => :build
  depends_on 'py3_six' => :build
  depends_on 'shared_mime_info' # L
  depends_on 'util_linux' # R
  depends_on 'zlibpkg' # R
  depends_on 'pcre2' # R

  no_strip if %w[aarch64 armv7l].include? ARCH
  patchelf
  gnome

  def self.build
    system "meson #{CREW_MESON_OPTIONS.gsub('strip=true', 'strip=false')} \
    -Dselinux=disabled \
    -Dsysprof=disabled \
    -Dman=false \
    -Dtests=false \
    builddir"
    system 'meson configure builddir'
    system 'mold -run ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
