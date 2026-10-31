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
    aarch64: '2e1ad59a4420d744533784c057f96762da7c45449b9a0bb2b585000a945e523b',
     armv7l: '2e1ad59a4420d744533784c057f96762da7c45449b9a0bb2b585000a945e523b',
       i686: 'a79f30814f9bd19a4e2460d1a63559a3969c3293b1c65dac34168658f7add2d1',
     x86_64: '3d969428ad65b8371898f22dede7072fe6730a9ece0197d151bc28ce168a2a46'
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
