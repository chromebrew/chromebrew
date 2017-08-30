require 'package'

class Libssh2 < Package
  description 'libssh2 is a client-side C library implementing the SSH2 protocol.'
  homepage 'https://www.libssh2.org/'
  version '1.8.0'
  source_url 'https://www.libssh2.org/download/libssh2-1.8.0.tar.gz'
  source_sha256 '39f34e2f6835f4b992cafe8625073a88e5a28ba78f83e8099610a7b3af4676d4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.8.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.8.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.8.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.8.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6fa84296583273dd9e749a2c54cb1cf688a7dab032e2528de5944a4d9777f037',
     armv7l: '6fa84296583273dd9e749a2c54cb1cf688a7dab032e2528de5944a4d9777f037',
       i686: '771b2d30a49dd691db8456f773da404753d368f3c31d03c682c552ea0b5eb65e',
     x86_64: '6e026450389021c6267a9cc79b8722d15f48e2f8d812d5212501f686b4368e3c',
  })

  depends_on 'openssl' => :build
  depends_on 'zlibpkg' => :build

  def self.build
    system "./configure", "--libdir=#{CREW_LIB_PREFIX}", "--with-zlib", "--with-openssl", "--with-pic", "--disable-static"
    system "make"
    system "find . -name '*.so.*' -print | xargs strip -S"
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
