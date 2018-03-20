require 'package'

class Libunbound < Package
  description 'Unbound is a validating, recursive, and caching DNS resolver.'
  homepage 'https://www.unbound.net/'
  version '1.7.0'
  source_url 'https://www.unbound.net/downloads/unbound-1.7.0.tar.gz'
  source_sha256 '94dd9071fb13d8ccd122a3ac67c4524a3324d0e771fc7a8a7c49af8abfb926a2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libunbound-1.7.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libunbound-1.7.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libunbound-1.7.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libunbound-1.7.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4444835bc92d3e88e94ad6f1e9599f4c60a2843d206d2a2b15a31460816f76d5',
     armv7l: '4444835bc92d3e88e94ad6f1e9599f4c60a2843d206d2a2b15a31460816f76d5',
       i686: '3a2daf9725731c9aa89b3fd495e8fc8e87ff66a0906d8cd5c2ac120860f3e63b',
     x86_64: '54e53fa1bb5a673611048619d031cf57ef2dc259b4265ade626b661b71a91864',
  })

  depends_on 'flex' => :build
  depends_on 'bison' => :build
  depends_on 'gawk' => :build
  depends_on 'expat'

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
