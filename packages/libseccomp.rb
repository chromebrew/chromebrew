require 'package'

class Libseccomp < Package
  description 'The libseccomp library provides an easy to use, platform independent, interface to the Linux Kernel\'s syscall filtering mechanism.'
  homepage 'https://github.com/seccomp/libseccomp'
  version '2.4.1'
  compatibility 'all'
  source_url 'https://github.com/seccomp/libseccomp/archive/v2.4.1.tar.gz'
  source_sha256 '36aa502c0461ae9efc6c93ec2430d6badd9bf91ecbe73806baf7b7c6f687ab4f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libseccomp-2.4.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libseccomp-2.4.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libseccomp-2.4.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libseccomp-2.4.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c857c381ba1cd7bc53d0c760d33b308dd0e8b24893828745ac2d9697f4098266',
     armv7l: 'c857c381ba1cd7bc53d0c760d33b308dd0e8b24893828745ac2d9697f4098266',
       i686: 'e29d38e68b4a4043ef55a39a07b9dcb42429c6fdefedc50842cce784e0670fe7',
     x86_64: 'fb72ad86487e84775255ad3c231e4517f490094cfed05da2d22274e2f1006257',
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
