require 'package'

class Openrtsp < Package
  description 'openRTSP is a command-line program that can be used to open, stream, receive, and (optionally) record media streams that are specified by a RTSP URL - i.e., an URL that begins with rtsp://'
  homepage 'http://www.live555.com/openRTSP/'
  version '2018.02.28'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'http://www.live555.com/liveMedia/public/live.2018.02.28.tar.gz'
  source_sha256 '2db4f05616bdd21a609baf82c836486c44820c16a006315e02abe2b0b53a247e'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'a3e306b8e07bb82bd96414ca429f6ec395eb2edf1af39930920ef563b5c696d9',
     armv7l: 'a3e306b8e07bb82bd96414ca429f6ec395eb2edf1af39930920ef563b5c696d9',
       i686: 'ec6cffedbd6404b6175ddbdff1d64634c44a5c852d8232b94319c9cde6aab761',
     x86_64: '8750845fd5e8469badc4a6d7c7c5026719efc788bbde3abfa1de083cb61732af'
  })

  def self.build
    system './genMakefiles linux'
    system "CPP_FLAGS='-Wno-deprecated' PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX} make"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
