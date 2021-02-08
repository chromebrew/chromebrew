require 'package'

class Libhandy < Package
  description 'The aim of the handy library is to help with developing UI for mobile devices using GTK/GNOME.'
  homepage 'https://gitlab.gnome.org/GNOME/libhandy/'
  @_ver = '1.0.3'
  version @_ver
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/libhandy/-/archive/#{@_ver}/libhandy-#{@_ver}.tar.bz2"
  source_sha256 '8cdeb88deaf13efbc0da73306bf8f8d14b6e5b108807a4f7b43d6a7c6e3a158d'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libhandy-1.0.3-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libhandy-1.0.3-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/libhandy-1.0.3-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libhandy-1.0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '4e5c2b68cdf5884bf233086a4cb8258c39d7c4f3abc84e262b9dc485292eff1a',
      armv7l: '4e5c2b68cdf5884bf233086a4cb8258c39d7c4f3abc84e262b9dc485292eff1a',
        i686: 'fabc2b197a1b8c6c1560a0ba3dd4f6a1839715e38f7079a11bd6169dbf54f38b',
      x86_64: 'b2b09e3a0ded79ce0ab151c489d95549c3b8c508ee485d8fdfdb4f4e0edcfb29',
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
