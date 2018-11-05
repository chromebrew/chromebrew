require 'package'

class Python3 < Package
  description 'Python is a programming language that lets you work quickly and integrate systems more effectively.'
  homepage 'https://www.python.org/'
  version '3.7.1'
  source_url 'https://www.python.org/ftp/python/3.7.1/Python-3.7.1.tar.xz'
  source_sha256 'fa7e2b8e8c9402f192ad56dc4f814089d1c4466c97d780f5e5acc02c04243d6d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/python3-3.7.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/python3-3.7.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/python3-3.7.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/python3-3.7.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c6ad3a008510f5cbafc94d23e2470fe350b75bd4dcce4c20bce69d5ba3dc7f15',
     armv7l: 'c6ad3a008510f5cbafc94d23e2470fe350b75bd4dcce4c20bce69d5ba3dc7f15',
       i686: '51c94f7be089b8515bb03eacb5812c4080f93201565406d438fb2cd9e2a4cb50',
     x86_64: '434f8f1156f89cb15dcbbdbf3a6e0448c931e5f5480dc1c5550694f014aab315',
  })

  depends_on 'bz2'
  depends_on 'xzutils'
  depends_on 'sqlite'
  depends_on 'krb5'
  depends_on 'libtirpc'

  def self.build
    # IMPORTANT: Do not build with python3 already installed or pip3 will not be included.
    # python requires /usr/local/lib, so leave as is but specify -rpath
    system "./configure", "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses -I#{CREW_PREFIX}/include/ncursesw",
      "LDFLAGS=-Wl,-rpath,-L#{CREW_LIB_PREFIX}",
      "--with-ensurepip=install", "--enable-shared"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"

    # remove static libraries
    system "find #{CREW_DEST_PREFIX} -name 'libpython*.a' -print | xargs -r rm"

    # create symbolic links in lib64 for other applications which use libpython
    unless Dir.exist? "#{CREW_DEST_LIB_PREFIX}"
      system "mkdir -p #{CREW_DEST_LIB_PREFIX}"
      system "cd #{CREW_DEST_LIB_PREFIX} && ln -s ../lib/libpython*.so* ."
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
    #system "TMPDIR=#{CREW_PREFIX}/tmp http_proxy= https_proxy= ftp_proxy= make test"
  end
end
