require 'package'

class Libunbound < Package
  description 'Unbound is a validating, recursive, and caching DNS resolver.'
  homepage 'https://www.unbound.net/'
  version '1.6.2'
  source_url 'https://www.unbound.net/downloads/unbound-1.6.2.tar.gz'
  source_sha1 'de370b1ac8e260db9c4c1504453752713dd8818f'

  depends_on 'flex' => :build
  depends_on 'bison' => :build
  depends_on 'gawk' => :build
  depends_on 'expat'

  def self.build
    system "./configure", "--enable-shared", "--disable-static", "--with-pic"

    # flex 2.6.3 requires -P option to rename yylex and other funcions
    system "sed", "-i", "Makefile", "-e", '/$(LEX) -t $(srcdir)\/util\/configlexer.lex/s:-t:-t -Pub_c_:'

    system "make"
    system "make", "strip"
    system "find . -name 'lib*.so.*' -print | xargs strip -S"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "test"
  end
end
