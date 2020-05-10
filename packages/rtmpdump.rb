require 'package'

class Rtmpdump < Package
  description 'rtmpdump is a toolkit for RTMP streams.'
  homepage 'https://rtmpdump.mplayerhq.hu/'
  version 'fa8646dae'
  compatibility 'all'
  source_url 'https://git.ffmpeg.org/gitweb/rtmpdump.git/snapshot/fa8646daeb19dfd12c181f7d19de708d623704c0.tar.gz'
  source_sha256 'dba4d4d2e1c7de6884b01d98194b83cab6784669089fa3c919152087a3a38fd2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/rtmpdump-fa8646dae-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/rtmpdump-fa8646dae-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/rtmpdump-fa8646dae-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/rtmpdump-fa8646dae-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '04a7e360b0290d82402addc6432d6b4d3c551aafb99ab3902bf30df6de2bdeae',
     armv7l: '04a7e360b0290d82402addc6432d6b4d3c551aafb99ab3902bf30df6de2bdeae',
       i686: '2298fa49696d409dbfe0bd159d4199b1219d2da4a1746fb5c1644f2f0a94a5d7',
     x86_64: '163c47847d3cfcfe9178995c96511e7642991a1bb567f90d33f26e36e85d16e6',
  })

  def self.build
    system "sed -i 's,prefix=/usr/local,prefix=#{CREW_PREFIX},' Makefile"
    system "sed -i 's,prefix=/usr/local,prefix=#{CREW_PREFIX},' librtmp/Makefile"
    system "sed -i 's,libdir=\$(prefix)/lib,libdir=#{CREW_LIB_PREFIX},' librtmp/Makefile"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
