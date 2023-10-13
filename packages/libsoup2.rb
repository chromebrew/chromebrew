require 'package'

class Libsoup2 < Package
  description 'libsoup is an HTTP client/server library for GNOME.'
  homepage 'https://wiki.gnome.org/Projects/libsoup'
  version '2.74.2'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libsoup.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsoup2/2.74.2_armv7l/libsoup2-2.74.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsoup2/2.74.2_armv7l/libsoup2-2.74.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsoup2/2.74.2_i686/libsoup2-2.74.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsoup2/2.74.2_x86_64/libsoup2-2.74.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '603f80f5597fe0d7bee189cd3f6078c506f124f85be57c634f04616c06bde8f9',
     armv7l: '603f80f5597fe0d7bee189cd3f6078c506f124f85be57c634f04616c06bde8f9',
       i686: '4f8c4a00bdc08d0dbbcbd15075e175130ad9545910206ffd5bef22534e47df18',
     x86_64: 'f5ed2100923109b22f46b8eefeffa429b4b98d1cb8a27d6fe3ac39fb3d38603c'
  })

  depends_on 'brotli' # R
  depends_on 'glibc' # R
  depends_on 'glib_networking'
  depends_on 'glib' # R
  depends_on 'krb5' # R
  depends_on 'libevent'
  depends_on 'libpsl' # R
  depends_on 'libxml2' # R
  # depends_on 'qtbase' => :build
  depends_on 'sqlite' # R
  depends_on 'vala' => :build
  depends_on 'zlibpkg' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      -Dtests=false \
      -Dsysprof=disabled \
      -Dintrospection=enabled \
      builddir"
    system 'meson configure --no-pager builddir'
    system "sed -i 's#-R#-Wl,-rpath=#g' builddir/build.ninja"
    system 'mold -run samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
