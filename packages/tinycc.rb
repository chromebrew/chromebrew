require 'package'

class Tinycc < Package
  description 'TinyCC (aka TCC) is a small but hyper fast C compiler.'
  homepage 'http://bellard.org/tcc/'
  version '0.9.26'
  source_url 'http://download.savannah.gnu.org/releases/tinycc/tcc-0.9.26.tar.bz2'
  source_sha256 '521e701ae436c302545c3f973a9c9b7e2694769c71d9be10f70a2460705b6d71'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
