require 'package'

class Python27 < Package
  description 'Python is a programming language that lets you work quickly and integrate systems more effectively.'
  homepage 'https://www.python.org/'
  version '2.7.18-1'
  license 'custom'
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
    raise StandardError, 'Please remove python27 before building.' if File.exist?("#{CREW_PREFIX}/bin/python2.7")
    # python requires #{CREW_LIB_PREFIX}, so leave as is but specify -rpath
    # SSL errors in test may require a 2021 version of libressl.

    system './configure', " -I#{CREW_PREFIX}/include/ncursesw",
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
