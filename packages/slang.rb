require 'package'

class Slang < Package
  description 'S-Lang is a multi-platform programmer\'s library designed to allow a developer to create robust multi-platform software.'
  homepage 'http://www.jedsoft.org/slang/'
  version '2.3.1a-1'
  source_url 'http://www.jedsoft.org/releases/slang/slang-2.3.1a.tar.bz2'
  source_sha256 '54f0c3007fde918039c058965dffdfd6c5aec0bad0f4227192cc486021f08c36'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/slang-2.3.1a-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/slang-2.3.1a-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/slang-2.3.1a-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/slang-2.3.1a-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '62868aea89e8cacb5de9e6eb7c76bd91604bb52bf3f0d3acfb5c47fc15e76bba',
     armv7l: '62868aea89e8cacb5de9e6eb7c76bd91604bb52bf3f0d3acfb5c47fc15e76bba',
       i686: 'db92dbb4200f37acd33dc558e35496088c8d975fa4dc8273afbd212a419f9dd5',
     x86_64: '15ff98f70426d6c55a5a99687862b9bbf5c5f3f6d6cc9ea47fabd0eb4a8277c8',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--without-x'

    # force to compile in sequential since slang Makefile doesn't work in parallel
    system "make", "-j1"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
