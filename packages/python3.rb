require 'package'

class Python3 < Package
  description 'Python is a programming language that lets you work quickly and integrate systems more effectively.'
  homepage 'https://www.python.org/'
  version '3.6.0'
  source_url 'https://www.python.org/ftp/python/3.6.0/Python-3.6.0.tgz'
  source_sha1 '120d536ee14a3153fc2435838c0f27c2e25cd29c'

  depends_on 'bz2' => :build
  depends_on 'xzutils' => :build
  depends_on 'ncurses'
  depends_on 'openssl' => :build
  depends_on 'sqlite' => :build

  def self.build
    system "./configure", "CPPFLAGS=-I/usr/local/include/ncurses -I/usr/local/include/ncursesw",
      "--with-ensurepip=install", "--enable-shared"
    system "make"

    # strip debug symbols from library
    system "find . -name '*.so' -print | xargs strip -S" unless @@debug_symbol
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"

    # strip binary
    system "strip", "#{CREW_DEST_DIR}/usr/local/bin/python3" unless @@debug_symbol

    # remove static library
    system "find #{CREW_DEST_DIR}/usr/local -name 'libpython*.a' -print | xargs rm"

    # remove cache (byte-code) files from install package
    system "find #{CREW_DEST_DIR}/usr/local -name '__pycache__' -print | xargs rm -rf"
  end

  def self.check
    # Chromebook doesn't allow SIGHUP, so disable SIGHUP test
    system "sed", "-i", "Lib/test/test_asyncio/test_events.py", "-e", "/Don't have SIGHUP/s/win32/linux/"
    system "sed", "-i", "Lib/test/test_asyncio/test_subprocess.py", "-e", "/Don't have SIGHUP/s/win32/linux/"

    # Chromebook returns EINVAL for F_NOTIFY DN_MULTISHOT, so disable test_fcntl_64_bit
    system "sed", "-i", "Lib/test/test_fcntl.py", "-e", '/ARM Linux returns EINVAL for F_NOTIFY DN_MULTISHOT/s/$/\
    @unittest.skipIf(platform.system() == '"'Linux'"', "Chromeos returns EINVAL for F_NOTIFY DN_MULTISHOT")/'

    # imaplib test used to use a kind of security hole on a server in university and the hole is closed now.
    # See https://bugs.python.org/issue30175 and https://github.com/python/cpython/pull/1320/files for details.
    system "sed", "-i", "Lib/test/test_imaplib.py",
        "-e", '/test_logincapa_with_client_certfile/i\ \ \ \ @unittest.skipIf(True,\
                     "bpo-30175: FIXME: cyrus.andrew.cmu.edu doesn\'t accept "\
                     "our randomly generated client x509 certificate anymore")',
        "-e", '/test_logincapa_with_client_ssl_context/i\ \ \ \ @unittest.skipIf(True,\
                     "bpo-30175: FIXME: cyrus.andrew.cmu.edu doesn\'t accept "\
                     "our randomly generated client x509 certificate anymore")'

    # skip gdb test since we are stripping debug symbols
    system "sed", "-i", "Lib/test/test_gdb.py",
        "-e", '/get_gdb_version/iraise unittest.SkipTest("only for python install with debug symbols")' unless @@debug_symbol

    # Using /tmp breaks test_distutils, test_subprocess
    # Proxy setting breaks test_httpservers, test_ssl,
    # test_urllib, test_urllib2, test_urllib2_localnet
    system "TMPDIR=/usr/local/tmp http_proxy= https_proxy= ftp_proxy= make test"
  end
end
