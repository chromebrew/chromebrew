require 'package'

class Libva < Package
  description 'Libva is an implementation for VA-API (VIdeo Acceleration API)'
  homepage 'https://01.org/linuxmedia'
  @_ver = '2.10.0'
  version "#{@_ver}-2"
  license 'MIT'
  compatibility 'all'
  source_url "https://github.com/intel/libva/releases/download/#{@_ver}/libva-#{@_ver}.tar.bz2"
  source_sha256 'fa81e35b50d9818fce5ec9eeeeff08a24a8864ceeb9a5c8e7ae4446eacfc0236'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libva-2.10.0-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libva-2.10.0-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libva-2.10.0-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libva-2.10.0-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '9e988606a1aa5f6334be989638016bf13f12f53436175e3852ac4d353084cb15',
     armv7l: '9e988606a1aa5f6334be989638016bf13f12f53436175e3852ac4d353084cb15',
       i686: 'c2224c241da00d19a01e5d47aeff24da900bde1818e99c9bc2f9a9178f4e9aa7',
     x86_64: '833e6a04798cdd78665b3be09beb9d4f3874748f77b720fc324d3c121acfa8f3'
  })

  depends_on 'libdrm'
  depends_on 'libx11'
  depends_on 'libxext'
  depends_on 'libxfixes'
  depends_on 'mesa'
  depends_on 'wayland'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    --default-library=both \
    -Db_lto=true \
    -Db_pie=true \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
