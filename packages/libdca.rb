require 'package'

class Libdca < Package
  description 'libdca is a free library for decoding DTS Coherent Acoustics streams.'
  homepage 'https://www.videolan.org/developers/libdca.html'
  version '0.0.7'
  compatibility 'all'
  license 'GPL-2'
  source_url 'https://get.videolan.org/libdca/0.0.7/libdca-0.0.7.tar.bz2'
  source_sha256 '3a0b13815f582c661d2388ffcabc2f1ea82f471783c400f765f2ec6c81065f6a'
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: '66d6d64c9b1c9fe75c4085dbf420012fc4d9742568b1355ec4c7dbec1d694680',
      armv7l: '66d6d64c9b1c9fe75c4085dbf420012fc4d9742568b1355ec4c7dbec1d694680',
        i686: 'cf2225b24b34ea05a78ec57cd4da38f935598e6364e4add1afa7a4793e08454f',
      x86_64: 'c07c259c1a52a3171a35705e31b86fdba92b71c23582210b508b9167d4babda2'
  })

  def self.build
    system 'autoupdate'
    system 'autoreconf -fiv'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
