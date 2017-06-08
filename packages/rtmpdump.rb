require 'package'

class Rtmpdump < Package
  description 'rtmpdump is a toolkit for RTMP streams.'
  homepage 'https://rtmpdump.mplayerhq.hu/'
  version 'fa8646d'
  source_url 'https://git.ffmpeg.org/gitweb/rtmpdump.git/snapshot/fa8646daeb19dfd12c181f7d19de708d623704c0.tar.gz'
  source_sha1 '2faefe655b72f91540f39eebc3020f1c9dcc654e'

  def self.build
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
