require 'package'

class Git < Package
  version '2.11.0'
  source_url 'https://github.com/git/git/archive/v2.11.0.tar.gz'
  source_sha1 'ca1187843b7dd2bb3b1c5e275f04c17fa70e7100'
  binary_url ({
#    armv7l: 'https://dl.dropboxusercontent.com/s/lnz5hmjv48d14f2/git-1.8.4-chromeos-armv7l.tar.xz',
#    i686: 'https://dl.dropboxusercontent.com/s/g3binxopw5nfky1/git-1.8.4-chromeos-i686.tar.gz?token_hash=AAEWnMNBfozSIzLD1unbYGJzT4FGkEfJmLFQ-3uzydfT_A&dl=1',
#    x86_64: 'https://dl.dropboxusercontent.com/s/i7vs9wfk94tsrzt/git-1.8.4-chromeos-x86_64.tar.gz?token_hash=AAHyvjayN7THoxlryZaxQ2Ejm9xyD6bZCqXZM81hYRC8iQ&dl=1'
  })
  binary_sha1 ({
    armv7l: '084a3b9bb90c572e7c5b12aae485715f145053e5',
    i686: '8c1bf4bcffb0e9c17bf20dd05981e86ea34d5d65',
    x86_64: '067cb6c36616ac30999ab97e85f3dc0e9d1d57f4'
  })

  # compile-time dependencies
  depends_on 'zlibpkg'
  depends_on 'libssh2'
  depends_on 'openssl'
  depends_on 'perl'
  depends_on 'curl'
  depends_on 'expat'
  depends_on 'gettext'
  depends_on 'python'

  # no run-time dependency (need empty line)
  rdepends_on

  def self.build
    system "make", "prefix=/usr/local", "CC=gcc", "PERL_PATH=perl", "PYTHON_PATH=python3", "all"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "prefix=/usr/local", "CC=gcc", "PERL_PATH=perl", "PYTHON_PATH=python3", "install"
  end
end
