require 'package'

class Libunbound < Package
  description 'Unbound is a validating, recursive, and caching DNS resolver.'
  homepage 'https://www.unbound.net/'
  version '1.7.3'
  source_url 'https://www.unbound.net/downloads/unbound-1.7.3.tar.gz'
  source_sha256 'c11de115d928a6b48b2165e0214402a7a7da313cd479203a7ce7a8b62cba602d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libunbound-1.7.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libunbound-1.7.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libunbound-1.7.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libunbound-1.7.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '27f917465295015394aed113d07edde320ce977185c55883a875fccfb269d47b',
     armv7l: '27f917465295015394aed113d07edde320ce977185c55883a875fccfb269d47b',
       i686: 'e5765e59f11ee3aa5ada3a9571607cdaef2522de2986c74e895063e6e04353c9',
     x86_64: '3cd8a50cc5ffd19a56d086e5990590eac27f32e78099bf75288902078f487e9f',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-shared',
           '--disable-static',
           '--with-pic'

    # flex 2.6.3 requires -P option to rename yylex and other funcions
    system "sed", "-i", "Makefile", "-e", '/$(LEX) -t $(srcdir)\/util\/configlexer.lex/s:-t:-t -Pub_c_:'

    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "test"
  end
end
