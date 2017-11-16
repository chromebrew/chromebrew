require 'package'

class Python3 < Package
  description 'Python is a programming language that lets you work quickly and integrate systems more effectively.'
  homepage 'https://www.python.org/'
  version '3.6.4'
  source_url 'https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tar.xz'
  source_sha256 '159b932bf56aeaa76fd66e7420522d8c8853d486b8567c459b84fe2ed13bcaba'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'bz2' => :build
  depends_on 'xzutils' => :build
  depends_on 'ncurses'
  depends_on 'openssl' => :build
  depends_on 'sqlite' => :build
  depends_on 'zlibpkg'

  def self.build
    # python requires to use /usr/local/lib, so leave as is but specify -rpath
    system "./configure", "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses -I#{CREW_PREFIX}/include/ncursesw",
      "LDFLAGS=-Wl,-rpath,-L#{CREW_LIB_PREFIX}",
      "--with-ensurepip=#{ARGV[0]}", "--enable-shared"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"

    # remove static library
    system "find #{CREW_DEST_PREFIX} -name 'libpython*.a' -print | xargs -r rm"

    # create symbolic links in lib64 for other applications which use libpython
    unless Dir.exist? "#{CREW_DEST_LIB_PREFIX}"
      system "mkdir -p #{CREW_DEST_LIB_PREFIX}"
      system "cd #{CREW_DEST_LIB_PREFIX}; ln -s ../lib/libpython*.so* ."
    end
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

    # Using /tmp breaks test_distutils, test_subprocess
    # Proxy setting breaks test_httpservers, test_ssl,
    # test_urllib, test_urllib2, test_urllib2_localnet
    system "TMPDIR=#{CREW_PREFIX}/tmp http_proxy= https_proxy= ftp_proxy= make test"
  end
end
