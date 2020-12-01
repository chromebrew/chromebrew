require 'package'

class Python27 < Package
  description 'Python is a programming language that lets you work quickly and integrate systems more effectively.'
  homepage 'https://www.python.org/'
  version '2.7.18'
  compatibility 'all'
  source_url 'https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tar.xz'
  source_sha256 'b62c0e7937551d0cc02b8fd5cb0f544f9405bafc9a54d3808ed4594812edef43'


  depends_on 'bz2' => :build
  depends_on 'sqlite' => :build

    # Using /tmp breaks test_distutils, test_subprocess.
    # Proxy setting breaks test_httpservers, test_ssl,
    # test_urllib, test_urllib2, test_urllib2_localnet.
    # So, modifying environment variable to make pass tests.
    ENV['TMPDIR'] = "#{CREW_PREFIX}/tmp"
  def self.build
    # IMPORTANT: Do not build with python27 already installed or pip will not be included.
    # python requires #{CREW_LIB_PREFIX}, so leave as is but specify -rpath
    # SSL errors in test may require a 2021 version of libressl.
    
    system "./configure", "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses -I#{CREW_PREFIX}/include/ncursesw",
        "LDFLAGS=-Wl,-rpath,-L#{CREW_LIB_PREFIX}",
        "--enable-shared",
        "--enable-optimizations"
    system "make -j#{CREW_NPROC}"
    
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
    
    # Install pip
    system "curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py"
    # Set maximum version of setuptools compatible with python 2.7.
    system "LD_LIBRARY_PATH=$LD_LIBRARY_PATH:#{CREW_DEST_LIB_PREFIX} #{CREW_DEST_PREFIX}/bin/python ./get-pip.py setuptools==44.1.1 --prefix=#{CREW_PREFIX} --root=#{CREW_DEST_DIR}"
    # pip is in python3. Remove python2 pip since deprecated and leave pip2
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/pip"
    system "sed -i \"s%#{CREW_DEST_PREFIX}/bin/python%#{CREW_PREFIX}/bin/python%g\" #{CREW_DEST_PREFIX}/bin/pip2"
  end

  def self.check
    #system "http_proxy= https_proxy= ftp_proxy= make test"
  end
end
