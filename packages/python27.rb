require 'package'

class Python27 < Package
  description 'Python is a programming language that lets you work quickly and integrate systems more effectively.'
  homepage 'https://www.python.org/'
  version '2.7.13-2'
  source_url 'https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tar.xz'
  source_sha256 '35d543986882f78261f97787fd3e06274bfa6df29fac9b4a94f73930ff98f731'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/python27-2.7.13-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/python27-2.7.13-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/python27-2.7.13-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/python27-2.7.13-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c49956a1b82245c016fa0e865f638ca7b04bca1f6a3053ddda1226f51f17370d',
     armv7l: 'c49956a1b82245c016fa0e865f638ca7b04bca1f6a3053ddda1226f51f17370d',
       i686: '3bc20fdd9d63cb11da172d1ddbf5098a2778a26b782f2c900a42794a12230eba',
     x86_64: '966adcff41706773c3c0ee9819728b3f95603d80d73be06a1057240cee75fe0d',
  })

  depends_on 'bz2' => :build
  depends_on 'ncurses'
  depends_on 'openssl' => :build
  depends_on 'sqlite' => :build
  depends_on 'gdbm' => :build
  depends_on 'zlibpkg'

  def self.build
    # python requires to use /usr/local/lib, so leave as is but specify -rpath
    system "./configure", "CPPFLAGS=-I/usr/local/include/ncurses -I/usr/local/include/ncursesw",
        "LDFLAGS=-Wl,-rpath,#{CREW_PREFIX}/lib",
        "--with-ensurepip=install", "--enable-shared"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"

    # remove static library
    system "find #{CREW_DEST_DIR}/usr/local -name 'libpython*.a' -print | xargs -r rm"

    # create symbolic links in lib64 for other applications which use libpython
    unless Dir.exist? "#{CREW_DEST_DIR}#{CREW_LIB_PREFIX}"
      system "mkdir -p #{CREW_DEST_DIR}#{CREW_LIB_PREFIX}"
      system "cd #{CREW_DEST_DIR}#{CREW_LIB_PREFIX}; ln -s ../lib/libpython*.so* ."
    end
  end

  def self.check
    # Using /tmp breaks test_distutils, test_subprocess.
    # Proxy setting breaks test_httpservers, test_ssl,
    # test_urllib, test_urllib2, test_urllib2_localnet.
    # So, modifying environment variable to make pass tests.
    system "TMPDIR=/usr/local/tmp http_proxy= https_proxy= ftp_proxy= make test"
  end
end
