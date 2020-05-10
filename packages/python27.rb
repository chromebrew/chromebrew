require 'package'

class Python27 < Package
  description 'Python is a programming language that lets you work quickly and integrate systems more effectively.'
  homepage 'https://www.python.org/'
  version '2.7.17'
  compatibility 'all'
  source_url 'https://www.python.org/ftp/python/2.7.17/Python-2.7.17.tar.xz'
  source_sha256 '4d43f033cdbd0aa7b7023c81b0e986fd11e653b5248dac9144d508f11812ba41'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/python27-2.7.17-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/python27-2.7.17-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/python27-2.7.17-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/python27-2.7.17-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '753d3df25a3353384c6d938a907305825d5f6d8eda3189a18de877c3d5dc6075',
     armv7l: '753d3df25a3353384c6d938a907305825d5f6d8eda3189a18de877c3d5dc6075',
       i686: 'a3c9214188a6648ade671337591b93a4e8b53e733442a6db6bbd366559605928',
     x86_64: '671417cd3cdc21f4196fb7515beeb8c3a1d4fbc302cf4a3094a504ab71291fd4',
  })

  depends_on 'bz2' => :build
  depends_on 'sqlite' => :build

  def self.build
    # IMPORTANT: Do not build with python27 already installed or pip will not be included.
    # python requires #{CREW_LIB_PREFIX}, so leave as is but specify -rpath
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
    # Using /tmp breaks test_distutils, test_subprocess.
    # Proxy setting breaks test_httpservers, test_ssl,
    # test_urllib, test_urllib2, test_urllib2_localnet.
    # So, modifying environment variable to make pass tests.
    #system "TMPDIR=#{CREW_PREFIX}/tmp http_proxy= https_proxy= ftp_proxy= make test"
  end
end
