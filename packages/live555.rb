require 'package'

class Live555 < Package
  description 'This code forms a set of C++ libraries for multimedia streaming, using open standard protocols (RTP/RTCP, RTSP, SIP).'
  homepage 'http://www.live555.com'
  version '2026.11.05'
  license 'LGPL'
  compatibility 'all'
  source_url "https://download.live555.com/live.#{version}.tar.gz"
  source_sha256 'a9001fed451a2e5bc429f1f4cb4efd3eb9840ca429891f7e64f743a5a44b7333'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '76d81f02a59629b05de0c0caeb6b65a6a03489d975b3b3031dbfb8b37fd4ae1c',
     armv7l: '76d81f02a59629b05de0c0caeb6b65a6a03489d975b3b3031dbfb8b37fd4ae1c',
       i686: '2fc1c55ad70dc354e8688680619148de52218c32d988d4687546b50ee1d84353',
     x86_64: '0e6682056d0ac83872f946a720aecab319af676633da4ad26faa35a296958bb9'
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
