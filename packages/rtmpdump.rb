require 'package'

class Rtmpdump < Package
  description 'rtmpdump is a toolkit for RTMP streams.'
  homepage 'https://rtmpdump.mplayerhq.hu/'
  version 'fa8646d'
  source_url 'https://git.ffmpeg.org/gitweb/rtmpdump.git/snapshot/fa8646daeb19dfd12c181f7d19de708d623704c0.tar.gz'
  source_sha256 'dba4d4d2e1c7de6884b01d98194b83cab6784669089fa3c919152087a3a38fd2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/rtmpdump-fa8646d-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/rtmpdump-fa8646d-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/rtmpdump-fa8646d-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/rtmpdump-fa8646d-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '562e165ac1cbb290e9b450a27492f4eabbd36774326a8d023d17ddf4c2661db3',
     armv7l: '562e165ac1cbb290e9b450a27492f4eabbd36774326a8d023d17ddf4c2661db3',
       i686: '73c220545ca018ae7191533423f17ede1be7366fe189d5aff3b0c2a0777063cd',
     x86_64: 'bac487e52b05e2b61754a22fe92df0f4178a34479679b7d526fd31460e1951b9',
  })

  def self.build
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
