require 'package'

class Git < Package
  version '2.11.0'
  source_url 'https://github.com/git/git/archive/v2.11.0.tar.gz'
  source_sha1 'ca1187843b7dd2bb3b1c5e275f04c17fa70e7100'
  binary_url ({
    armv7l: 'https://github.com/jam7/chromebrew/releases/download/binaries/git-2.11.0-chromeos-armv7l.tar.xz',
    i686:   'https://github.com/jam7/chromebrew/releases/download/binaries/git-2.11.0-chromeos-i686.tar.xz',
    x86_64: 'https://github.com/jam7/chromebrew/releases/download/binaries/git-2.11.0-chromeos-x86_64.tar.xz',
  })
  binary_sha1 ({
    armv7l: '1d04e232826fcbeff7a20da6a3b0ab3b823d2cd2',
    i686:   '7dd3b08c9b1e2a219494b6c77efc1b6773ef08f4',
    x86_64: 'd8345b00742cadf4f34585f61cf49da5d5f7a695',
  })

  # compile-time dependencies
  depends_on 'zlibpkg'
  depends_on 'libssh2'
  depends_on 'openssl'
  depends_on 'perl'
  depends_on 'curl'
  depends_on 'expat'
  depends_on 'gettext'
  depends_on 'python27'     # git requires python2

  def self.build
    # need to build using single core
    system "make", "-j1", "prefix=/usr/local", "CC=gcc", "PERL_PATH=perl", "PYTHON_PATH=python2", "all"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "prefix=/usr/local", "CC=gcc", "PERL_PATH=perl", "PYTHON_PATH=python2", "install"
  end
end
