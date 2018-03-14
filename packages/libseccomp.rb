require 'package'

class Libseccomp < Package
  description 'The libseccomp library provides an easy to use, platform independent, interface to the Linux Kernel\'s syscall filtering mechanism.'
  homepage 'https://github.com/seccomp/libseccomp'
  version '2.3.3'
  source_url 'https://github.com/seccomp/libseccomp/archive/v2.3.3.tar.gz'
  source_sha256 '5a52495207f00d1254707f11226e17c16ec53f5038d65bbabf1892873fa2fe5b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libseccomp-2.3.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libseccomp-2.3.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libseccomp-2.3.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libseccomp-2.3.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c91f75159f6f611093aa259edb509f235cb490c8789931f9e905b2e39b9f3609',
     armv7l: 'c91f75159f6f611093aa259edb509f235cb490c8789931f9e905b2e39b9f3609',
       i686: 'e244798d1d0cf120f925e0bece4f507bfed73e975aeb2c73b6910452ece85252',
     x86_64: 'b7b39bcc650e34789b860a565cea3abda054a7f2755e5d8516d3574b612223cd',
  })

  def self.build
    system './autogen.sh'
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
