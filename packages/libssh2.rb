require 'package'

class Libssh2 < Package
  description 'libssh2 is a client-side C library implementing the SSH2 protocol.'
  homepage 'https://www.libssh2.org/'
  version '1.8.0-1'
  source_url 'https://www.libssh2.org/download/libssh2-1.8.0.tar.gz'
  source_sha256 '39f34e2f6835f4b992cafe8625073a88e5a28ba78f83e8099610a7b3af4676d4'

  depends_on 'openssl' => :build
  depends_on 'zlibpkg' => :build

  def self.build
    system "./configure", "--libdir=#{CREW_LIB_PREFIX}", "--with-zlib", "--with-openssl", "--with-pic", "--enable-shared", "--disable-static"
    system "make"
    system "find . -name '*.so.*' -print | xargs strip -S"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "libtool --finish #{CREW_LIB_PREFIX}"
    case ARCH
    when "x86_64"
      FileUtils.cd("#{CREW_PREFIX}/lib") do
        system "ln -s #{CREW_LIB_PREFIX}/libssh2.la libssh2.la"
        system "ln -s #{CREW_LIB_PREFIX}/libssh2.so.1.0.1 libssh2.so"
        system "ln -s #{CREW_LIB_PREFIX}/libssh2.so.1.0.1 libssh2.so.1"
        system "ln -s #{CREW_LIB_PREFIX}/libssh2.so.1.0.1 libssh2.so.1.0.1"
      end
    end
  end

  def self.check
    # Ignore mansyntax.sh test which checks man page syntax errors.
    # It causes 'col: Invalid or incomplete multibyte or wide character'
    # error at hyphenations.  It is mandb's problem.
    system "sed -i tests/Makefile -e '/TESTS =/s/mansyntax.sh//'"
    system "make", "check"
  end
end
