require 'package'

class Python27 < Package
  description 'Python is a programming language that lets you work quickly and integrate systems more effectively.'
  homepage 'https://www.python.org/'
  version '2.7.13-2'
  source_url 'https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tar.xz'
  source_sha256 '35d543986882f78261f97787fd3e06274bfa6df29fac9b4a94f73930ff98f731'

  depends_on 'bz2' => :build
  depends_on 'ncurses'
  depends_on 'openssl' => :build
  depends_on 'sqlite' => :build
  depends_on 'gdbm' => :build

  def self.build
    system "./configure", "CPPFLAGS=-I/usr/local/include/ncurses -I/usr/local/include/ncursesw", "--with-ensurepip=install", "--enable-shared"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"

    # remove static library
    system "find #{CREW_DEST_DIR}/usr/local -name 'libpython*.a' -print | xargs rm"
  end

  def self.check
    # Using /tmp breaks test_distutils, test_subprocess.
    # Proxy setting breaks test_httpservers, test_ssl,
    # test_urllib, test_urllib2, test_urllib2_localnet.
    # So, modifying environment variable to make pass tests.
    system "TMPDIR=/usr/local/tmp http_proxy= https_proxy= ftp_proxy= make test"
  end
end
