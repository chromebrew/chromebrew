require 'package'

class Python27 < Package
  description 'Python is a programming language that lets you work quickly and integrate systems more effectively.'
  homepage 'https://www.python.org/'
  version '2.7.16'
  source_url 'https://www.python.org/ftp/python/2.7.16/Python-2.7.16.tar.xz'
  source_sha256 'f222ef602647eecb6853681156d32de4450a2c39f4de93bd5b20235f2e660ed7'

  binary_url ({
  })
  binary_sha256 ({
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
