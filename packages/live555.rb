require 'package'

class Live555 < Package
  description 'This code forms a set of C++ libraries for multimedia streaming, using open standard protocols (RTP/RTCP, RTSP, SIP).'
  homepage 'http://www.live555.com'
  version '2026.07.23'
  license 'LGPL'
  compatibility 'all'
  source_url "https://download.live555.com/live.#{version}.tar.gz"
  source_sha256 '4b4bcdbdaa4a2b060ba9e193312bd0819dd134fc4aff01aff998d08ad6f2aeac'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '280bd63390278f2d72e5d0ee61f02a8308d26946c1efeac6dcf6ae9ceb670c61',
     armv7l: '280bd63390278f2d72e5d0ee61f02a8308d26946c1efeac6dcf6ae9ceb670c61',
       i686: '5b29a1862dde9309454316df01e8f53e089029b70c54916e3eef64a1f88edf62',
     x86_64: 'd40057720fd7bcb12788a2dd537ba26f51f700b240288c71421184bd57aef3b0'
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
