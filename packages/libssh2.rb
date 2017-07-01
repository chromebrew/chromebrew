require 'package'

class Libssh2 < Package
  description 'libssh2 is a client-side C library implementing the SSH2 protocol.'
  homepage 'https://www.libssh2.org/'
  version '1.8.0'
  source_url 'https://www.libssh2.org/download/libssh2-1.8.0.tar.gz'
  source_sha256 '39f34e2f6835f4b992cafe8625073a88e5a28ba78f83e8099610a7b3af4676d4'

  depends_on 'openssl' => :build
  depends_on 'zlibpkg' => :build

  def self.build
    system "./configure", "--with-zlib", "--with-openssl", "--with-pic", "--disable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    # Ignore mansyntax.sh test which checks man page syntax errors.
    # It causes 'col: Invalid or incomplete multibyte or wide character'
    # error at hyphenations.  It is mandb's problem.
    system "sed -i tests/Makefile -e '/TESTS =/s/mansyntax.sh//'"

    system "make", "check"
  end
end
