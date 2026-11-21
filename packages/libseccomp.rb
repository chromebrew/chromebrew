require 'package'

class Libseccomp < Package
  description 'The libseccomp library provides an easy to use, platform independent, interface to the Linux Kernel\'s syscall filtering mechanism.'
  homepage 'https://github.com/seccomp/libseccomp'
  version '2.6.2'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://github.com/seccomp/libseccomp/archive/v#{version}.tar.gz"
  source_sha256 '4e3dfa94dfc4c2aa21e5e707e5bfebc87063f2461b1d22f84e9d1ed507db7e4b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5034d2f72ec8410f4d86a5e3392e66a2e0ca46e81330704c9c79db87b4c105a3',
     armv7l: '5034d2f72ec8410f4d86a5e3392e66a2e0ca46e81330704c9c79db87b4c105a3',
       i686: '1e7a212258c8f93fbe5591e8f3ad44b4c5966aa613d2722bba4e71ac3614379a',
     x86_64: 'fc281c5b736a7e40e786a6d3e49ca93a86adacb4beb50ba17ff8338de9bf85e8'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
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
