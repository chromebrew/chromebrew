require 'package'

class Tinycc < Package
  description 'TinyCC (aka TCC) is a small but hyper fast C compiler.'
  homepage 'http://bellard.org/tcc/'
  version '0.9.26'
  source_url 'http://download.savannah.gnu.org/releases/tinycc/tcc-0.9.26.tar.bz2'
  source_sha256 '521e701ae436c302545c3f973a9c9b7e2694769c71d9be10f70a2460705b6d71'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tinycc-0.9.26-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tinycc-0.9.26-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tinycc-0.9.26-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tinycc-0.9.26-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c78b224e101a385e611ea9e558f743248113e954f4e9ef038e15e7ac1491e0d9',
     armv7l: 'c78b224e101a385e611ea9e558f743248113e954f4e9ef038e15e7ac1491e0d9',
       i686: 'fb9164d86849536d3d81dadea75232e2fe2c1392c20ae0e8974aecbb9300141c',
     x86_64: '45ee7ac7842428d52742be8b4aa873b0bb7fa301995a4cf303c85b22751897f8',
  })

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
