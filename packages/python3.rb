require 'package'

class Python3 < Package
  description 'Python is a programming language that lets you work quickly and integrate systems more effectively.'
  homepage 'https://www.python.org/'
  version '3.8.6'
  compatibility 'all'
  source_url 'https://www.python.org/ftp/python/3.8.6/Python-3.8.6.tar.xz'
  source_sha256 'a9e0b79d27aa056eb9cce8d63a427b5f9bab1465dee3f942dcfdb25a82f4ab8a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/python3-3.8.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/python3-3.8.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/python3-3.8.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/python3-3.8.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'eba6c478f3560887eddffb7d0cf919d919fcce9f69422844f124f5871d35ed21',
     armv7l: 'eba6c478f3560887eddffb7d0cf919d919fcce9f69422844f124f5871d35ed21',
       i686: 'e547b40c0d37330308a1dce7a38c3149ffbbbb8fe28b96688e91fc3e1e491290',
     x86_64: 'e00af2fe0ac111fb00ae4809e6b21dcf9f44c100d81f8459ed4b8304e16ab34c',
  })

  depends_on 'bz2'
  depends_on 'xzutils'
  depends_on 'sqlite'
  depends_on 'krb5'
  depends_on 'libtirpc'

  def self.preinstall
    # Fix ImportError: cannot import name 'PackageFinder'.
    # See https://stackoverflow.com/questions/59887436/importerror-cannot-import-name-packagefinder.
    FileUtils.rm_rf Dir.glob("#{CREW_PREFIX}/lib/python3.8/site-packages/pip*")
  end

  def self.build
    # IMPORTANT: Do not build with python3 already installed or pip3 will not be included.
    # python requires /usr/local/lib, so leave as is but specify -rpath
    system './configure', "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses -I#{CREW_PREFIX}/include/ncursesw",
      "LDFLAGS=-Wl,-rpath,-L#{CREW_LIB_PREFIX}",
      '--with-ensurepip=install', '--enable-shared'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'

    # remove static libraries
    system "find #{CREW_DEST_PREFIX} -name 'libpython*.a' -print | xargs -r rm"

    # create symbolic links in lib64 for other applications which use libpython
    unless Dir.exist? CREW_DEST_LIB_PREFIX
      FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
      system "cd #{CREW_DEST_LIB_PREFIX} && ln -s ../lib/libpython*.so* ."
    end
  end

  def self.postinstall
    puts
    puts "Upgrading pip...".lightblue
    system 'pip3 install --upgrade pip'
    puts
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
    #system "TMPDIR=#{CREW_PREFIX}/tmp http_proxy= https_proxy= ftp_proxy= make test"
  end
end
