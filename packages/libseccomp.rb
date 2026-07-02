require 'package'

class Libseccomp < Package
  description 'The libseccomp library provides an easy to use, platform independent, interface to the Linux Kernel\'s syscall filtering mechanism.'
  homepage 'https://github.com/seccomp/libseccomp'
  version '2.6.1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://github.com/seccomp/libseccomp/archive/v#{version}.tar.gz"
  source_sha256 'f9a13e4c633d319a9240189760ca348caa0837c0ebe2a09b17061da8ceaf60f0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a8783ff0030df832a3953dec6636fee9b2f1f2f28cc5ef63d8a0402290bff715',
     armv7l: 'a8783ff0030df832a3953dec6636fee9b2f1f2f28cc5ef63d8a0402290bff715',
       i686: 'e2b315bd37a85937ab2dc12dbdca901d0c03e4668b9e41e0d8794b247224d8e8',
     x86_64: '3865f48498cc24e4d5e27b28faf9a830b1686ed5701919180958c33d187308bb'
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
