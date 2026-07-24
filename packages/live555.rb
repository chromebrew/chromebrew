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
    aarch64: '3aeca1b4f6f4d4794140ad2d6703780b0fcb56af8876a5252b3037b547b145b1',
     armv7l: '3aeca1b4f6f4d4794140ad2d6703780b0fcb56af8876a5252b3037b547b145b1',
       i686: '8f1c444c3c430b71418edfda381a57b91ee9c10becb2ff2eb55cb947576a910f',
     x86_64: '984eb39cd180faf76197fdcbe94176919e4eed09e847766b2dec8f67cf0e9fc3'
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
