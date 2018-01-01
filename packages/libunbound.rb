require 'package'

class Libunbound < Package
  description 'Unbound is a validating, recursive, and caching DNS resolver.'
  homepage 'https://www.unbound.net/'
  version '1.6.7'
  source_url 'https://www.unbound.net/downloads/unbound-1.6.7.tar.gz'
  source_sha256 '4e7bd43d827004c6d51bef73adf941798e4588bdb40de5e79d89034d69751c9f'

  binary_url ({
  })
  binary_sha256 ({
  })

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
