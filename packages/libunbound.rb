require 'package'

class Libunbound < Package
  description 'Unbound is a validating, recursive, and caching DNS resolver.'
  homepage 'https://www.unbound.net/'
  version '1.6.2'
  source_url 'https://www.unbound.net/downloads/unbound-1.6.2.tar.gz'
  source_sha256 '1a323d72c32180b7141c9e6ebf199fc68a0208dfebad4640cd2c4c27235e3b9c'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libunbound-1.6.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libunbound-1.6.2-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/libunbound-1.6.2-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/libunbound-1.6.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '72a4c0a18e74232aed3c619e97fcd41a9df18a8887b9f5f7b45ab7cb9e0f4e1b',
     armv7l: '72a4c0a18e74232aed3c619e97fcd41a9df18a8887b9f5f7b45ab7cb9e0f4e1b',
       i686: '2fd2b4fc97ab09228022f8f76a9fdb64da733dcbd68de247273c34887b749570',
     x86_64: 'dde8bd43e4fb63f9c21d751198efffce41a4ea59db965a69540538d670ea5048',
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
