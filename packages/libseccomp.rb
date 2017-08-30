require 'package'

class Libseccomp < Package
  description 'The libseccomp library provides an easy to use, platform independent, interface to the Linux Kernel\'s syscall filtering mechanism.'
  homepage 'https://github.com/seccomp/libseccomp'
  version '2.3.2'
  source_url 'https://github.com/seccomp/libseccomp/releases/download/v2.3.2/libseccomp-2.3.2.tar.gz'
  source_sha256 '3ddc8c037956c0a5ac19664ece4194743f59e1ccd4adde848f4f0dae7f77bca1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libseccomp-2.3.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libseccomp-2.3.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libseccomp-2.3.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libseccomp-2.3.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '83d4acaa5276acd45867901b59f5eb3e777f26269b7768ac5d8021d014f6d521',
     armv7l: '83d4acaa5276acd45867901b59f5eb3e777f26269b7768ac5d8021d014f6d521',
       i686: '0027702b09d708c66fa6bfefecada190878f29aa5840a7e062e425b999ea9625',
     x86_64: '1e6dfc6369d132f5bf4ff0ed7aadf3fea4359c2dbeb8f372755620d26105b835',
  })


  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
