require 'package'

class Live555 < Package
  description 'This code forms a set of C++ libraries for multimedia streaming, using open standard protocols (RTP/RTCP, RTSP, SIP).'
  homepage 'http://www.live555.com'
  version '2026.10.22'
  license 'LGPL'
  compatibility 'all'
  source_url "https://download.live555.com/live.#{version}.tar.gz"
  source_sha256 '248b3968bb095ad93fd592ee35f438748b0064a98bba3740a6467ff2a7f4bec3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1113ba18d079497f9d8242d049348e802df040edf2a2bc26fab0889412f2101b',
     armv7l: '1113ba18d079497f9d8242d049348e802df040edf2a2bc26fab0889412f2101b',
       i686: 'c4771ca34e7e08186e0342d3fd24953c200c9c10219f31a0920da48bf4f222ff',
     x86_64: 'bc7c45fed10dc1b5963a05d81644b34825d6200fcd58f5c82fcbc5e34af00ece'
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
