require 'package'

class Live555 < Package
  description 'This code forms a set of C++ libraries for multimedia streaming, using open standard protocols (RTP/RTCP, RTSP, SIP).'
  homepage 'http://www.live555.com'
  version '2026.10.23'
  license 'LGPL'
  compatibility 'all'
  source_url "https://download.live555.com/live.#{version}.tar.gz"
  source_sha256 'edb5cc03ab575127d1ac880d12171da8188fad795cfc2fa7767917975a3785af'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5f600cc31fafb8980a4cf5905fa755856ab2411dea4048fd3ac1421359754677',
     armv7l: '5f600cc31fafb8980a4cf5905fa755856ab2411dea4048fd3ac1421359754677',
       i686: 'ea12c13cf765657036ad4bbeabfa58c757e3f0d5dee37d1c3368fe917c6ad8b7',
     x86_64: '8dcc270e7ac5bc8118b1267158aa92bc04f93ac9e9c90a553481ff1a434d0ea3'
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
