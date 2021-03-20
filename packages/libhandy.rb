require 'package'

class Libhandy < Package
  description 'The aim of the handy library is to help with developing UI for mobile devices using GTK/GNOME.'
  homepage 'https://gitlab.gnome.org/GNOME/libhandy/'
  @_ver = '1.2.0'
  version @_ver
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/libhandy/-/archive/#{@_ver}/libhandy-#{@_ver}.tar.bz2"
  source_sha256 'b2e08210a6b0c6b08e6c46848024cbcf44973e40377a1373d7cbb0bde7131b56'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libhandy-1.2.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libhandy-1.2.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libhandy-1.2.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libhandy-1.2.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '402449264e9ba6e35d2346fb0f3b5999c404281d73d60dfb4aa953c8e017b93b',
     armv7l: '402449264e9ba6e35d2346fb0f3b5999c404281d73d60dfb4aa953c8e017b93b',
       i686: '599fbe3faa80ca1ac1666bb49576624c5d667b56582df727a73613d29d0537ff',
     x86_64: 'a611807332097568b87cf04af35042940c505e693e5b6970969b93634fd7db0f'
  })

  depends_on 'vala'

  def self.prebuild
    system "sed -i 's,-fstack-protector-strong,-fno-stack-protector,' meson.build"
  end

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
