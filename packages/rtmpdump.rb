require 'package'

class Rtmpdump < Package
  description 'rtmpdump is a toolkit for RTMP streams.'
  homepage 'https://rtmpdump.mplayerhq.hu/'
  version 'fa8646da'
  source_url 'https://git.ffmpeg.org/gitweb/rtmpdump.git/snapshot/fa8646daeb19dfd12c181f7d19de708d623704c0.tar.gz'
  source_sha256 'dba4d4d2e1c7de6884b01d98194b83cab6784669089fa3c919152087a3a38fd2'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "sed -i 's,prefix=/usr/local,prefix=#{CREW_PREFIX},' Makefile"
    system "sed -i 's,prefix=/usr/local,prefix=#{CREW_PREFIX},' librtmp/Makefile"
    system "sed -i 's,libdir=\$(prefix)/lib,libdir=#{CREW_LIB_PREFIX},' librtmp/Makefile"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
