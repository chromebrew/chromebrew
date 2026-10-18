require 'package'

class Live555 < Package
  description 'This code forms a set of C++ libraries for multimedia streaming, using open standard protocols (RTP/RTCP, RTSP, SIP).'
  homepage 'http://www.live555.com'
  version '2026.10.17'
  license 'LGPL'
  compatibility 'all'
  source_url "https://download.live555.com/live.#{version}.tar.gz"
  source_sha256 '577b2fe2c5fe2c0240707e8be2d3e3fdb0c7eea0d7aca8ec84d75974773b5cd5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '24941aeccbc1d7332d0b43303df2236f6508b037ccbfacb88a3d06a83f74bfe9',
     armv7l: '24941aeccbc1d7332d0b43303df2236f6508b037ccbfacb88a3d06a83f74bfe9',
       i686: '56996d532e6a82318868ccdbb21b6bc5b265988e33caa57053de8c854b179cfa',
     x86_64: 'faa97f3dc33b057439a19496c216aa93383aa850af550fefe8df9f53056a6437'
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
