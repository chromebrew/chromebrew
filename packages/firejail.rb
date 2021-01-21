require 'package'

class Firejail < Package
  description 'Firejail is a SUID program that reduces the risk of security breaches by restricting the running environment of untrusted applications
  by using Linux namespaces and seccomp-bpf.'
  homepage 'https://firejail.wordpress.com'
  compatibility 'all'
  version '0.9.54'
  source_url 'https://sourceforge.net/projects/firejail/files/firejail/firejail-0.9.54.tar.xz'
  source_sha256 'ce996854278863f3e91ff185198c7cc1377fb70053d37a43e3b1ef1021c57756'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/firejail-0.9.54-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/firejail-0.9.54-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/firejail-0.9.54-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/firejail-0.9.54-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6a5a4b9f191482d5fb5259d9b7a6e8487bff6dca1b44e859d78a9c98c474805c',
     armv7l: '6a5a4b9f191482d5fb5259d9b7a6e8487bff6dca1b44e859d78a9c98c474805c',
       i686: 'b5e81766f7cd14ea389ed9b767178d113e4073e021c67b6cf7a2ab26a8dcc00f',
     x86_64: 'c6c490e1955926bebba1a01bac60472fc9d1a536ad4339b6ab1c5ac278be2b53',
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
