require 'package'

class Openrtsp < Package
  description '"openRTSP" is a command-line program that can be used to open, stream, receive, and (optionally) record media streams that are specified by a RTSP URL - i.e., an URL that begins with rtsp://'
  homepage 'http://www.live555.com/openRTSP/'
  version '2018.02.28'
  source_url 'http://www.live555.com/liveMedia/public/live.2018.02.28.tar.gz'
  source_sha256 '2db4f05616bdd21a609baf82c836486c44820c16a006315e02abe2b0b53a247e'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system './genMakefiles linux'
    system "CPP_FLAGS='-Wno-deprecated' PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX} make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
