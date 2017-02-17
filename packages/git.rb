require 'package'

class Git < Package
  version '2.11.0'
  source_url 'https://github.com/git/git/archive/v2.11.0.tar.gz'
  source_sha1 'ca1187843b7dd2bb3b1c5e275f04c17fa70e7100'
  binary_url ({
    armv7l: 'https://dl.dropboxusercontent.com/s/l6evyt7uvu8pcyb/git-2.11.0-chromeos-armv7l.tar.xz',
    x86_64: 'https://dl.dropboxusercontent.com/s/71m9oldde6hq8f1/git-2.11.0-chromeos-x86_64.tar.xz',
  })
  binary_sha1 ({
    armv7l: 'd4b9da420c2e411767332b6d65cfacf1ad4e5a94',
    x86_64: '0e2e495096c683f38bac334b4d4eb5d6381163bb',
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
