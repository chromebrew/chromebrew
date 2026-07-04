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
    aarch64: 'db3d1f51162960022b3f5ed066d062263f7b94c8fe4c9c7084fd2c6efcb7276e',
     armv7l: 'db3d1f51162960022b3f5ed066d062263f7b94c8fe4c9c7084fd2c6efcb7276e',
       i686: '5a51058917a3418a6d8932b2364695dde2ef1ccbc3261f3c1ce2746a1b3118b2',
     x86_64: 'b406a3ab21cd0103d4e10426449a51e24b9b33e2123d1d083ce0aa4e1edab1f5'
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
