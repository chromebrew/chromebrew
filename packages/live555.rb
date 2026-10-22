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
    aarch64: 'b76cb26e37328aa0cc42c23b9423b2063e2661e4cd1d588e9bd569b86786118b',
     armv7l: 'b76cb26e37328aa0cc42c23b9423b2063e2661e4cd1d588e9bd569b86786118b',
       i686: '2a9c0f4cdc86fe941bf25e9fd397d591f6117c2445d6291743066614aa4a7913',
     x86_64: '46bc5a96521205756a02b9718a5994ec18866a754acf83140156ae5f85930d59'
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
