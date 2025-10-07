require 'package'

class Libseccomp < Package
  description 'The libseccomp library provides an easy to use, platform independent, interface to the Linux Kernel\'s syscall filtering mechanism.'
  homepage 'https://github.com/seccomp/libseccomp'
  version '2.6.0'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://github.com/seccomp/libseccomp/archive/v#{version}.tar.gz"
  source_sha256 '0889a8da98e37f86019c90789fd4ff7eda6e1ceb9ef07d4c51c67aeb50a77860'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f2423dd691c12162eb08ee628a0167b7fa88ad3d9ff89dcbef0e670ef92e5eec',
     armv7l: 'f2423dd691c12162eb08ee628a0167b7fa88ad3d9ff89dcbef0e670ef92e5eec',
       i686: '168ea8232d31e954477b08eabcd0f08b563f8151983906b38cbe6ce243b36806',
     x86_64: 'a5cb3ebe2ae90e90d090596d5fb37178a8a13e528fe47917608ad004a6a38f91'
  })

  depends_on 'glibc' # R
  depends_on 'gperf' => :build

  def self.build
    system './autogen.sh'
    system "./configure \
      #{CREW_CONFIGURE_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
