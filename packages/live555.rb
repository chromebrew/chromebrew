require 'package'

class Live555 < Package
  description 'This code forms a set of C++ libraries for multimedia streaming, using open standard protocols (RTP/RTCP, RTSP, SIP).'
  homepage 'http://www.live555.com'
  version '2026.07.04'
  license 'LGPL'
  compatibility 'all'
  source_url "https://download.live555.com/live.#{version}.tar.gz"
  source_sha256 'b89b425ec6fedaa4dc0b478ba9146a431b265f5352cb17fc44c14402c512e378'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c998c4aa72e096ce7950ad5ea5491a04553040162f28d3d88da5ecb0d5ba6261',
     armv7l: 'c998c4aa72e096ce7950ad5ea5491a04553040162f28d3d88da5ecb0d5ba6261',
       i686: '2e9eadf8bdcd82183ed01c03ae58f42fcaa7e34df1473030c8ded1f45c000932',
     x86_64: 'bc3e1f0b685cb599f78f63dc747c85a4964d70d9cb511147a07eb8b31b5e7336'
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
