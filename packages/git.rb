require 'package'

class Git < Package
  version '2.11.0'
  source_url 'https://github.com/git/git/archive/v2.11.0.tar.gz'
  source_sha1 'ca1187843b7dd2bb3b1c5e275f04c17fa70e7100'

  # use system zlibpkg, openssl, curl, expat
  depends_on 'zlibpkg' => :build
  depends_on 'libssh2'
  depends_on 'openssl' => :build
  depends_on 'curl' => :build
  depends_on 'expat' => :build
  depends_on 'gettext' => :build
  depends_on 'perl' => :build
  depends_on 'python27' => :build     # requires python2

  def self.build
    # need to build using single core
    system "make", "-j1", "prefix=/usr/local", "CC=gcc", "PERL_PATH=perl", "PYTHON_PATH=python2", "all"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "prefix=/usr/local", "CC=gcc", "PERL_PATH=perl", "PYTHON_PATH=python2", "install"
  end
end
