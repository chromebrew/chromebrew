require 'package'

class Libunbound < Package
  description 'Unbound is a validating, recursive, and caching DNS resolver.'
  homepage 'https://www.unbound.net/'
  version '1.6.2'
  source_url 'https://www.unbound.net/downloads/unbound-1.6.2.tar.gz'
  source_sha256 '1a323d72c32180b7141c9e6ebf199fc68a0208dfebad4640cd2c4c27235e3b9c'

  depends_on 'flex' => :build
  depends_on 'bison' => :build
  depends_on 'gawk' => :build
  depends_on 'expat'

  def self.build
    system "./configure", "--libdir=#{CREW_LIB_PREFIX}", "--enable-shared", "--disable-static", "--with-pic"

    # flex 2.6.3 requires -P option to rename yylex and other funcions
    system "sed", "-i", "Makefile", "-e", '/$(LEX) -t $(srcdir)\/util\/configlexer.lex/s:-t:-t -Pub_c_:'

    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "test"
  end
end
