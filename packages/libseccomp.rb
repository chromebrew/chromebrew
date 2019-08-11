require 'package'

class Libseccomp < Package
  description 'The libseccomp library provides an easy to use, platform independent, interface to the Linux Kernel\'s syscall filtering mechanism.'
  homepage 'https://github.com/seccomp/libseccomp'
  version '2.4.1'
  source_url 'https://github.com/seccomp/libseccomp/archive/v2.4.1.tar.gz'
  source_sha256 '36aa502c0461ae9efc6c93ec2430d6badd9bf91ecbe73806baf7b7c6f687ab4f'

  binary_url ({
  })
  binary_sha256 ({
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
