require 'package'

class Live555 < Package
  description 'This code forms a set of C++ libraries for multimedia streaming, using open standard protocols (RTP/RTCP, RTSP, SIP).'
  homepage 'http://www.live555.com'
  version '2026.11.27'
  license 'LGPL'
  compatibility 'all'
  source_url "https://download.live555.com/live.#{version}.tar.gz"
  source_sha256 'b10f5f5ae768c2fa9c175d7ad31b2e17dcbde9598ef368f012921f55ad69c336'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a6e113292f27493e82e697ff4e171d23229847be885bc916f6e1cb297331e085',
     armv7l: 'a6e113292f27493e82e697ff4e171d23229847be885bc916f6e1cb297331e085',
       i686: '947450fc0fedd222452da617a279733723bda0ca014ba3988be8b218e7d3eb63',
     x86_64: '176f34bb00092181cc9141838e481cd4f75120d1fda6d131681a8ee495657497'
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
