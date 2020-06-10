require 'package'

class Python3 < Package
  description 'Python is a programming language that lets you work quickly and integrate systems more effectively.'
  homepage 'https://www.python.org/'
  version '3.8.2'
  compatibility 'all'
  source_url 'https://www.python.org/ftp/python/3.8.2/Python-3.8.2.tar.xz'
  source_sha256 '2646e7dc233362f59714c6193017bb2d6f7b38d6ab4a0cb5fbac5c36c4d845df'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/python3-3.8.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/python3-3.8.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/python3-3.8.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/python3-3.8.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '24a9d5c66ecb9889fab72ee5173c051e3ccb915e29787913bd70829695f6bd46',
     armv7l: '24a9d5c66ecb9889fab72ee5173c051e3ccb915e29787913bd70829695f6bd46',
       i686: '562d85cd5741021b00beacf85d80db6d9fd11583b16aea367789bca062e7de4f',
     x86_64: '6858a8d9e7c85f0261a1feb98c09237d969f9ae2f4bd039259842c5f9a2c4e33',
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
    unless Dir.exist? "#{CREW_DEST_LIB_PREFIX}"
      FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}"
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
