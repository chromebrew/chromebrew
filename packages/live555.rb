require 'package'

class Live555 < Package
  description 'This code forms a set of C++ libraries for multimedia streaming, using open standard protocols (RTP/RTCP, RTSP, SIP).'
  homepage 'http://www.live555.com'
  version '2026.10.29'
  license 'LGPL'
  compatibility 'all'
  source_url "https://download.live555.com/live.#{version}.tar.gz"
  source_sha256 '1b9e5d09543a287050ebcc64887677812acd60775e0280ee6f75b5c8445e5cc6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ff41bcf5cc7e44c10a7efb1f23ff8e05d12b2e6dffb8d9878311ed1b123da9d5',
     armv7l: 'ff41bcf5cc7e44c10a7efb1f23ff8e05d12b2e6dffb8d9878311ed1b123da9d5',
       i686: '74f375d062e42aaae5a9ed06809e3aa6e7782183d652e90ad2158372f68e53ee',
     x86_64: 'db4e2aa78ec39b19082a417a7aaa47ddfada3a4dd05ebdb321a8461c9432b044'
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
