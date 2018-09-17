require 'package'

class Libunbound < Package
  description 'Unbound is a validating, recursive, and caching DNS resolver.'
  homepage 'https://www.unbound.net/'
  version '1.8.0'
  source_url 'https://www.unbound.net/downloads/unbound-1.8.0.tar.gz'
  source_sha256 '78f79d6d3b643fdcd74a14fc76542250da886c82f82bc55b51e189663d61b83f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libunbound-1.8.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libunbound-1.8.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libunbound-1.8.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libunbound-1.8.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'be4733b2311bad10f4dac8f3032b525fade63c4829c5e4f474f93e7411f54df6',
     armv7l: 'be4733b2311bad10f4dac8f3032b525fade63c4829c5e4f474f93e7411f54df6',
       i686: 'a0652536ce6348433d476d06993f942df1b0c103f5bcdfef8eb70b1d07c87362',
     x86_64: '8668a925a7f46f477106661f561a2f6085cf23e389e26f86a23a46c0db064f12',
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
