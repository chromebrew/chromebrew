require 'package'

class Libseccomp < Package
  description 'The libseccomp library provides an easy to use, platform independent, interface to the Linux Kernel\'s syscall filtering mechanism.'
  homepage 'https://github.com/seccomp/libseccomp'
  version '2.3.3'
  source_url 'https://github.com/seccomp/libseccomp/archive/v2.3.3.tar.gz'
  source_sha256 '5a52495207f00d1254707f11226e17c16ec53f5038d65bbabf1892873fa2fe5b'



  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
