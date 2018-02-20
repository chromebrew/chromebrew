require 'package'

class Python27 < Package
  description 'Python is a programming language that lets you work quickly and integrate systems more effectively.'
  homepage 'https://www.python.org/'
  version '2.7.14-1'
  source_url 'https://www.python.org/ftp/python/2.7.14/Python-2.7.14.tar.xz'
  source_sha256 '71ffb26e09e78650e424929b2b457b9c912ac216576e6bd9e7d204ed03296a66'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/python27-2.7.14-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/python27-2.7.14-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/python27-2.7.14-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/python27-2.7.14-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b9b46abdff0324b9b701cd8dc36f7658a5780029bc9f6b6f8c45efbc6bfaca53',
     armv7l: 'b9b46abdff0324b9b701cd8dc36f7658a5780029bc9f6b6f8c45efbc6bfaca53',
       i686: '3d18cf9af249c18eab193f7fd22137612555bb5b877304838f74cc13fba9ad5e',
     x86_64: '099a31f3584cf2c0e65beeaace1b2c995d5fb64c8891fd0dce75c3cc7f8a6503',
  })

  depends_on 'bz2' => :build
  depends_on 'ncurses'
  depends_on 'openssl' => :build
  depends_on 'sqlite' => :build
  depends_on 'gdbm' => :build
  depends_on 'zlibpkg'

  def self.build
    # python requires to use /usr/local/lib, so leave as is but specify -rpath
    system "./configure", "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses -I#{CREW_PREFIX}/include/ncursesw",
        "LDFLAGS=-Wl,-rpath,-L#{CREW_LIB_PREFIX}",
        "--with-ensurepip=install", "--enable-shared"
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
    # Using /tmp breaks test_distutils, test_subprocess.
    # Proxy setting breaks test_httpservers, test_ssl,
    # test_urllib, test_urllib2, test_urllib2_localnet.
    # So, modifying environment variable to make pass tests.
    system "TMPDIR=#{CREW_PREFIX}/tmp http_proxy= https_proxy= ftp_proxy= make test"
  end
end
