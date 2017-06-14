require 'package'

class Git < Package
  description 'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.'
  homepage 'https://git-scm.com/'
  version '2.13.0'
  source_url 'https://github.com/git/git/archive/v2.13.0.tar.gz'
  source_sha1 'd0078048574b824bc0d202deb3830717a955eb3e'

  # use system zlibpkg, openssl, curl, expat
  depends_on 'zlibpkg' => :build
  depends_on 'libssh2'
  depends_on 'openssl' => :build
  depends_on 'curl' => :build
  depends_on 'expat' => :build
  depends_on 'gettext' => :build
  depends_on 'perl' => :build
  depends_on 'python27' => :build     # requires python2

  # need to build using single core
  @make_cmd = "make -j1 prefix=/usr/local CC=gcc PERL_PATH=/usr/local/bin/perl PYTHON_PATH=/usr/local/bin/python2"

  def self.build
    system "#{@make_cmd} all"
    system "#{@make_cmd} strip"
  end

  def self.install
    system "#{@make_cmd} DESTDIR=#{CREW_DEST_DIR} install"
  end

  def self.check
    # Skip several t9010-svn-fe and t9011-svn-da tests since they fail.
    system "GIT_SKIP_TESTS='t9010.16 t9010.20 t9011.1[49] t9011.2[0346] t9011.31 ' #{@make_cmd} test"
  end
end
