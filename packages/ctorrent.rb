require 'package'

class Ctorrent < Package
  description 'CTorrent is a BitTorrent client implemented in C++ to be lightweight and quick.'
  homepage 'http://www.rahul.net/dholmes/ctorrent/'
  version '3.3.2'
  compatibility 'all'
  source_url 'http://www.rahul.net/dholmes/ctorrent/ctorrent-dnh3.3.2.tar.gz'
  source_sha256 'c87366c91475931f75b924119580abd06a7b3cb3f00fef47346552cab1e24863'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ctorrent-3.3.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ctorrent-3.3.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ctorrent-3.3.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ctorrent-3.3.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '32f8e0727420efc33e670f025c1608fe4c8aec5cbf660a24fde1366dd8a85ef1',
     armv7l: '32f8e0727420efc33e670f025c1608fe4c8aec5cbf660a24fde1366dd8a85ef1',
       i686: '18e5029cb1032bf6a623197c06a5f023d1a3af53e421be77ab8950be52a5bda3',
     x86_64: '012252e1976bd0580c34f697cff7338b53d4989b6f52a02b5171807981aa1ec4',
  })

  depends_on 'openssl' => :build

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
