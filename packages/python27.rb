require 'package'

class Python27 < Package
  description 'Python is a programming language that lets you work quickly and integrate systems more effectively.'
  homepage 'https://www.python.org/'
  version '2.7.18'
  compatibility 'all'
  source_url 'https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tar.xz'
  source_sha256 'b62c0e7937551d0cc02b8fd5cb0f544f9405bafc9a54d3808ed4594812edef43'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/python27-2.7.18-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/python27-2.7.18-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/python27-2.7.18-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/python27-2.7.18-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c3f95252f2a2ebcf7659d1d38ef25752aa7cb1495c90d2baf69f1e91d51ad472',
     armv7l: 'c3f95252f2a2ebcf7659d1d38ef25752aa7cb1495c90d2baf69f1e91d51ad472',
       i686: '5219b6078f2ae15b32de827215b707e2efc166dbd7b9304772eb0716467b9ad9',
     x86_64: '6572621e821f572eb9f60b604c5f578339e6dca1f618601c61970095cc06b675',
  })

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

    system './configure', "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses -I#{CREW_PREFIX}/include/ncursesw",
        "LDFLAGS=-Wl,-rpath,-L#{CREW_LIB_PREFIX}",
        '--with-ensurepip=install',
        '--enable-optimizations',
        '--enable-shared'
    system 'make'
  end

  def self.check
    #system "http_proxy= https_proxy= ftp_proxy= make test"
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
    #puts
    #puts "Upgrading pip...".lightblue
    #system 'pip2 install --upgrade pip'
    #puts
    FileUtils.ln_sf "#{CREW_PREFIX}/bin/python3", "#{CREW_PREFIX}/bin/python" \
      if File.exist? "#{CREW_PREFIX}/bin/python3"
    FileUtils.ln_sf "#{CREW_PREFIX}/bin/pip3", "#{CREW_PREFIX}/bin/pip" \
      if File.exist? "#{CREW_PREFIX}/bin/pip3"
  end
end
