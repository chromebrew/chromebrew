require 'package'

class Live555 < Package
  description 'This code forms a set of C++ libraries for multimedia streaming, using open standard protocols (RTP/RTCP, RTSP, SIP).'
  homepage 'http://www.live555.com'
  version '2026.06.29'
  license 'LGPL'
  compatibility 'all'
  source_url "https://download.live555.com/live.#{version}.tar.gz"
  source_sha256 'f8f9f56968e160b2864db5afcd95dc719205df71237fec63a3ff883b1d34ca78'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f2cfc1378324de4ebb23956131a758b2f00f8fd1f3773052b6b5a64eab6f4867',
     armv7l: 'f2cfc1378324de4ebb23956131a758b2f00f8fd1f3773052b6b5a64eab6f4867',
       i686: '7ad637e62b70686c5325dff82e95987865eb06ed2420395e71ccab243e8cd539',
     x86_64: '5d745a7d90901d9077978fa84d93cdc43f8d4b348dda42997969986a92b76720'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'openssl' => :executable

  def self.build
    system './genMakefiles linux'
    system 'make'
  end

  def self.install
    system 'make',
           "PREFIX=#{CREW_PREFIX}",
           "LIBDIR=#{CREW_LIB_PREFIX}",
           "DESTDIR=#{CREW_DEST_DIR}",
           'INSTALL2=install_shared_libraries',
           'install'
  end
end
