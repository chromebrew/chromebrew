require 'package'

class Firejail < Package
  description 'Firejail is a SUID program that reduces the risk of security breaches by restricting the running environment of untrusted applications
  by using Linux namespaces and seccomp-bpf.'
  homepage 'https://firejail.wordpress.com'
  version '0.9.54'
  source_url 'https://sourceforge.net/projects/firejail/files/firejail/firejail-0.9.54.tar.xz'
  source_sha256 'ce996854278863f3e91ff185198c7cc1377fb70053d37a43e3b1ef1021c57756'

  binary_url ({
  })
  binary_sha256 ({
  })
  
  def self.build
    system "sed -i 's,-fstack-protector-all,,g' src/common.mk.in"
    system "sed -i 's,-fstack-protector-all,,g' src/libtrace/Makefile.in"
    system "sed -i 's,-fstack-protector-all,,g' src/libtracelog/Makefile.in"
    system "sed -i 's,-fstack-protector-all,,g' src/libpostexecseccomp/Makefile.in"
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
