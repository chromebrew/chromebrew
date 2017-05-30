require 'package'

class Libssh2 < Package
  description 'libssh2 is a client-side C library implementing the SSH2 protocol.'
  homepage 'https://www.libssh2.org/'
  version '1.8.0'
  source_url 'https://www.libssh2.org/download/libssh2-1.8.0.tar.gz'
  source_sha1 'baf2d1fb338eee531ba9b6b121c64235e089e0f5'

  depends_on 'openssl' => :build
  depends_on 'zlibpkg' => :build

  def self.build
    system "./configure", "--with-zlib", "--with-openssl", "--with-pic", "--disable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"

    # strip debug symbol from library
    system "strip -S #{CREW_DEST_DIR}/usr/local/lib/libssh2.so.*"
  end

  def self.check
    # Ignore mansyntax.sh test which checks man page syntax errors.
    # It causes 'col: Invalid or incomplete multibyte or wide character'
    # error at hyphenations.  It is mandb's problem.
    system "sed -i tests/Makefile -e '/TESTS =/s/mansyntax.sh//'"

    system "make", "check"
  end
end
