require 'package'

class Live555 < Package
  description 'This code forms a set of C++ libraries for multimedia streaming, using open standard protocols (RTP/RTCP, RTSP, SIP).'
  homepage 'http://www.live555.com'
  version '2026.06.12'
  license 'LGPL'
  compatibility 'all'
  source_url "https://download.live555.com/live.#{version}.tar.gz"
  source_sha256 'ee0e1387747d5fea46f4652249e13020714635fff1f507917122df86b58bd1cd'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5bef30a01dcd49821834dc096ddef83fc6d31bd5fc07fe30a61b21c37326de5b',
     armv7l: '5bef30a01dcd49821834dc096ddef83fc6d31bd5fc07fe30a61b21c37326de5b',
       i686: 'acea9ef0f5a82bf619b6d5ae787ff51a19cc3f3885cce974b9e6c039269c4134',
     x86_64: 'e52d0366a91af88f399ac47158a342ff9b2e590c0e8d8293ba0fc785790f5825'
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
