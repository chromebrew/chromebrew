require 'package'

class Libseccomp < Package
  description 'The libseccomp library provides an easy to use, platform independent, interface to the Linux Kernel\'s syscall filtering mechanism.'
  homepage 'https://github.com/seccomp/libseccomp'
  version '2.3.2'
  source_url 'https://github.com/seccomp/libseccomp/releases/download/v2.3.2/libseccomp-2.3.2.tar.gz'
  source_sha256 '3ddc8c037956c0a5ac19664ece4194743f59e1ccd4adde848f4f0dae7f77bca1'


  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
