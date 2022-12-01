require 'package'

class Libsoup < Package
  description 'libsoup is an HTTP client/server library for GNOME.'
  homepage 'https://wiki.gnome.org/Projects/libsoup'
  @_ver = '3.2.0'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libsoup.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsoup/3.2.0_armv7l/libsoup-3.2.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsoup/3.2.0_armv7l/libsoup-3.2.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsoup/3.2.0_i686/libsoup-3.2.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsoup/3.2.0_x86_64/libsoup-3.2.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5b92c80b65551d65ea05b85a305a118ff25c8654c23d0ae5b5d45446dea9efad',
     armv7l: '5b92c80b65551d65ea05b85a305a118ff25c8654c23d0ae5b5d45446dea9efad',
       i686: 'eabd2ca473234c6b422372bd7288e62213c4238eab0577fa3f7b046bf68fd215',
     x86_64: '8b232315cb2c066181c47ceb9e32e87baf9168ad8d1833ccc735f3f856a8feea'
  })

  depends_on 'glib_networking'
  depends_on 'vala'
  depends_on 'libsoup2' # This way we make sure packages which need the older libsoup-2.4 library get it too.
  depends_on 'py3_smartypants' => :build
  depends_on 'brotli' # R
  depends_on 'e2fsprogs' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'krb5' # R
  depends_on 'libnghttp2' # R
  depends_on 'libpsl' # R
  depends_on 'sqlite' # R
  depends_on 'zlibpkg' # R
  gnome

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      -Dtests=false \
      -Dsysprof=disabled \
      -Dintrospection=enabled \
      builddir"
    system 'meson configure builddir'
    system 'mold -run samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
