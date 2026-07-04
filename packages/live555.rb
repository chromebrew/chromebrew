require 'package'

class Live555 < Package
  description 'This code forms a set of C++ libraries for multimedia streaming, using open standard protocols (RTP/RTCP, RTSP, SIP).'
  homepage 'http://www.live555.com'
  version '2026.07.02'
  license 'LGPL'
  compatibility 'all'
  source_url "https://download.live555.com/live.#{version}.tar.gz"
  source_sha256 '92dd7aeff0f6d93f11aecab25670d30f974604b2d0dd71f6cdbfceecd92b31dd'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9e738e89d0353ccff0219ca4fedc193b2c9addb793d590f8a1c4f1c662a16bdf',
     armv7l: '9e738e89d0353ccff0219ca4fedc193b2c9addb793d590f8a1c4f1c662a16bdf',
       i686: '8a0e9f328c350c05e9b3929c4f67f31a1600e583bc4a74601b73987d38756865',
     x86_64: '2e807e8827f276d4819a91133fd491e666ee07f181104d5e6f537685ecd0ab47'
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
