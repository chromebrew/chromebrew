require 'package'

class Python27 < Package
  description 'Python is a programming language that lets you work quickly and integrate systems more effectively.'
  homepage 'https://www.python.org/'
  version '2.7.13-2'
  source_url 'https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tar.xz'
  source_sha1 '18a8f30a0356c751b8d0ea6f76e764cab13ee046'

  depends_on 'bz2' => :build
  depends_on 'ncurses'
  depends_on 'openssl' => :build
  depends_on 'sqlite' => :build
  depends_on 'gdbm' => :build

  def self.build
    system "./configure", "CPPFLAGS=-I/usr/local/include/ncurses -I/usr/local/include/ncursesw", "--with-ensurepip=install", "--enable-shared"
    system "make"

    # strip debug symbols from library
    system "find . -name '*.so' -print | xargs strip -S" unless @@debug_symbol
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"

    # strip binary
    system "strip", "#{CREW_DEST_DIR}/usr/local/bin/python2" unless @@debug_symbol

    # remove static library
    system "find #{CREW_DEST_DIR}/usr/local -name 'libpython*.a' -print | xargs rm"

    # remove cache (byte-code) files from install package
    system "find #{CREW_DEST_DIR}/usr/local -name '*.pyc' -o -name '*.pyo' | xargs rm"
  end

  def self.check
    # Using /tmp breaks test_distutils, test_subprocess.
    # Proxy setting breaks test_httpservers, test_ssl,
    # test_urllib, test_urllib2, test_urllib2_localnet.
    # So, modifying environment variable to make pass tests.
    system "TMPDIR=/usr/local/tmp http_proxy= https_proxy= ftp_proxy= make test"
  end
end
