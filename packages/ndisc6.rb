require 'package'

class Ndisc6 < Package
  description 'Small collection of useful tools for IPv6 networking (ndisc6, rdisc6, tcptraceroute6, traceroute6, rdnssd).'
  homepage 'https://www.remlab.net/ndisc6/'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.remlab.net/files/ndisc6/ndisc6-1.0.3.tar.bz2'
  source_sha256 '0f41d6caf5f2edc1a12924956ae8b1d372e3b426bd7b11eed7d38bc974eec821'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ndisc6-1.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ndisc6-1.0.3-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ndisc6-1.0.3-chromeos-x86_64.tar.xz',
    i686: 'file:///home/chronos/user/chromebrew/release/i686/ndisc6-1.0.3-chromeos-i686.tar.xz'
  })
  binary_sha256 ({
    aarch64: '72e919fab7d493afad497ec83786a905a96b7bd69802b5502890c9c5e4152127',
     armv7l: '72e919fab7d493afad497ec83786a905a96b7bd69802b5502890c9c5e4152127',
     x86_64: '7b73aa83893ad65101f439e85b6effed2776015ab0628ac436220fd57e00746b',
       i686: '2e588596a6ad9f99e3552761d3e51fbfc66ec574381406c4fa946aedf74362c5',
  })

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}", "--disable-suid-install"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
