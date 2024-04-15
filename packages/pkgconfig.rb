require 'package'

class Pkgconfig < Package
  description 'pkg-config is a helper tool used when compiling applications and libraries.'
  homepage 'https://gitlab.freedesktop.org/pkg-config/pkg-config'
  version '0.29.2-d97d'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/pkg-config/pkg-config/-/archive/d97db4fae4c1cd099b506970b285dc2afd818ea2/pkg-config-d97db4fae4c1cd099b506970b285dc2afd818ea2.tar.bz2'
  source_sha256 'beeeb23b4581241517e45e57d901459022376c3143f415fac1a1216d583b1796'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '5f3ad29987b8e93d88dce19fbd5b968809857d0267baab4f68d4a7129b06cd8b',
     armv7l: '5f3ad29987b8e93d88dce19fbd5b968809857d0267baab4f68d4a7129b06cd8b',
       i686: 'f9773b42423eaf021eb2104d568455661e879e3de80ffe54f78a74c3631186dc',
     x86_64: 'f17babbbfcf112c2bff4844545e401fe0c705062c1f354ac446da5e8021b7f1b'
  })

  depends_on 'glib' # R
  depends_on 'glibc' # R

  def self.build
    # As per https://gitlab.gnome.org/GNOME/glib/-/issues/1159
    # To fix broken check-print-options test
    system "sed -i '/glib-gettext.m4/d' glib/acinclude.m4"
    system 'env NOCONFIGURE=1 ./autogen.sh'
    case ARCH
    when 'x86_64'
      system "env CFLAGS='-pipe -flto=auto' \
        CXXFLAGS='-pipe -flto=auto' LDFLAGS='-flto=auto' \
        GLIB_CFLAGS='-I#{CREW_PREFIX}/include/glib-2.0 -I#{CREW_LIB_PREFIX}/glib-2.0/include' \
        GLIB_LIBS=-lglib-2.0 \
        ./configure #{CREW_OPTIONS} \
        --with-pc-path=#{CREW_PREFIX}/lib/pkgconfig:#{CREW_PREFIX}/lib64/pkgconfig:#{CREW_PREFIX}/share/pkgconfig \
        --with-system-include-path=/usr/include:#{CREW_PREFIX}/include \
        --with-system-library-path=#{CREW_LIB_PREFIX} \
        --enable-shared \
        --disable-host-tool \
        --with-libiconv=gnu"
    when 'i686', 'armv7l', 'aarch64'
      system "env CFLAGS='-pipe -flto=auto' \
        CXXFLAGS='-pipe -flto=auto' LDFLAGS='-flto=auto' \
        GLIB_CFLAGS='-I#{CREW_PREFIX}/include/glib-2.0 -I#{CREW_LIB_PREFIX}/glib-2.0/include' \
        GLIB_LIBS=-lglib-2.0 \
        ./configure #{CREW_OPTIONS} \
        --with-pc-path=#{CREW_PREFIX}/lib/pkgconfig:#{CREW_PREFIX}/share/pkgconfig \
        --with-system-include-path=/usr/include:#{CREW_PREFIX}/include \
        --with-system-library-path=#{CREW_LIB_PREFIX} \
        --enable-shared \
        --disable-host-tool \
        --with-libiconv=gnu"
    end
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
