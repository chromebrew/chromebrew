require 'package'

class Libhandy1 < Package
  description 'The aim of the handy library is to help with developing UI for mobile devices using GTK/GNOME.'
  homepage 'https://gitlab.gnome.org/GNOME/libhandy/'
  @_ver = '1.1.90'
  version @_ver
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/libhandy/-/archive/#{@_ver}/libhandy-#{@_ver}.tar.bz2"
  source_sha256 '6ddac98a287e4e9b31e3ec3d72dae756c4ef6e12f3b1150db7ec2ee339750bde'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libhandy1-1.1.90-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libhandy1-1.1.90-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libhandy1-1.1.90-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libhandy1-1.1.90-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '790a2510e89e4712c6d82cb07326b2fd5c9c34cc2e0f4fefe257d5fcc0c84615',
     armv7l: '790a2510e89e4712c6d82cb07326b2fd5c9c34cc2e0f4fefe257d5fcc0c84615',
       i686: 'fa28e0f5fdde0cc2cb79bf8cfff0222f3afe3de97025ffbd3f754722c4c3eb6c',
     x86_64: 'df36a10a4e9e86c84d98142bfbbec8e0431162002ffce3d0b837042d13a67d9f'
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
