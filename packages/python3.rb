require 'package'

class Python3 < Package
  description 'Python is a programming language that lets you work quickly and integrate systems more effectively.'
  homepage 'https://www.python.org/'
  @_ver = '3.9.2'
  version @_ver
  compatibility 'all'
  source_url "https://www.python.org/ftp/python/#{@_ver}/Python-#{@_ver}.tar.xz"
  source_sha256 '3c2034c54f811448f516668dce09d24008a0716c3a794dd8639b5388cbde247d'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/python3-3.9.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/python3-3.9.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/python3-3.9.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/python3-3.9.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '83b292381a6fcda63f3c8c6c4b682694be673b42ed14eb1482e5cfe6f1c0f835',
     armv7l: '83b292381a6fcda63f3c8c6c4b682694be673b42ed14eb1482e5cfe6f1c0f835',
       i686: '8f3ba22ea8824a958aafe9127e8fa078406323a6d9785e2986d3dc4ac45f671a',
     x86_64: 'd3195034ad9d26e9e4c0c08c35bff6f551cc5661b970284c96deb81f32d34fb8'
  })

  depends_on 'bz2'
  depends_on 'xzutils'
  depends_on 'sqlite'
  depends_on 'krb5'
  depends_on 'libtirpc'
  depends_on 'tk' => :build # yes this creates a circular dependency.
  depends_on 'gdbm' => :build

  def self.preinstall
    # Fix ImportError: cannot import name 'PackageFinder'.
    # See https://stackoverflow.com/questions/59887436/importerror-cannot-import-name-packagefinder.
    FileUtils.rm_rf Dir.glob("#{CREW_PREFIX}/lib/python3.9/site-packages/pip*")
  end

  def self.build
    # IMPORTANT: Do not build with python3 already installed or pip3 will not be included.
    raise StandardError, 'Please remove python3 before building.' if File.exist?("#{CREW_PREFIX}/bin/python3")

    @cppflags = "-fno-semantic-interposition -I#{CREW_PREFIX}/include/ncursesw"
    # python requires /usr/local/lib, so leave as is but specify -rpath
    @ldflags = "-fno-semantic-interposition -Wl,-rpath,-L#{CREW_LIB_PREFIX}"

    # Using /tmp breaks test_distutils, test_subprocess.
    # Proxy setting breaks test_httpservers, test_ssl,
    # test_urllib, test_urllib2, test_urllib2_localnet.
    # So, modifying environment variable to make pass tests.

    system "env TMPDIR=#{CREW_PREFIX}/tmp \
      CFLAGS='' \
      CXXFLAGS='' \
      CC='gcc -pthread' \
      CPPFLAGS='#{@cppflags}' \
      LDFLAGS='#{@ldflags}' \
      ./configure \
      #{CREW_OPTIONS} \
      --with-ensurepip=install \
      --enable-optimizations \
      --with-lto \
      --with-platlibdir='lib#{CREW_LIB_SUFFIX}' \
      --enable-shared"
    system 'make'
  end

  def self.check
    # Chromebook doesn't allow SIGHUP, so disable SIGHUP test
    system 'sed', '-i', 'Lib/test/test_asyncio/test_events.py', '-e', "/Don't have SIGHUP/s/win32/linux/"
    system 'sed', '-i', 'Lib/test/test_asyncio/test_subprocess.py', '-e', "/Don't have SIGHUP/s/win32/linux/"

    # Chromebook returns EINVAL for F_NOTIFY DN_MULTISHOT, so disable test_fcntl_64_bit
    system 'sed', '-i', 'Lib/test/test_fcntl.py', '-e', '/ARM Linux returns EINVAL for F_NOTIFY DN_MULTISHOT/s/$/\
    @unittest.skipIf(platform.system() == '"'Linux'"', "Chromeos returns EINVAL for F_NOTIFY DN_MULTISHOT")/'

    # imaplib test used to use a kind of security hole on a server in university and the hole is closed now.
    # See https://bugs.python.org/issue30175 and https://github.com/python/cpython/pull/1320/files for details.
    system 'sed', '-i', 'Lib/test/test_imaplib.py',
           '-e', '/test_logincapa_with_client_certfile/i\ \ \ \ @unittest.skipIf(True,\
                     "bpo-30175: FIXME: cyrus.andrew.cmu.edu doesn\'t accept "\
                     "our randomly generated client x509 certificate anymore")',
           '-e', '/test_logincapa_with_client_ssl_context/i\ \ \ \ @unittest.skipIf(True,\
                     "bpo-30175: FIXME: cyrus.andrew.cmu.edu doesn\'t accept "\
                     "our randomly generated client x509 certificate anymore")'

    # Using /tmp breaks test_distutils, test_subprocess
    # Proxy setting breaks test_httpservers, test_ssl,
    # test_urllib, test_urllib2, test_urllib2_localnet
    # system "TMPDIR=#{CREW_PREFIX}/tmp http_proxy= https_proxy= ftp_proxy= make test"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'

    # remove static libraries
    # system "find #{CREW_DEST_PREFIX} -name 'libpython*.a' -print | xargs -r rm"

    # create symbolic links in lib64 for other applications which use libpython
    unless Dir.exist? CREW_DEST_LIB_PREFIX
      FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
      system "cd #{CREW_DEST_LIB_PREFIX} && ln -s ../lib/libpython*.so* ."
    end
  end

  def self.postinstall
    puts
    puts 'Upgrading pip...'.lightblue
    system "curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} python3 get-pip.py -U"
    puts 'Setting Python3 as default python...'.lightblue
    FileUtils.rm "#{CREW_PREFIX}/bin/python"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/python3", "#{CREW_PREFIX}/bin/python"
    FileUtils.rm "#{CREW_PREFIX}/bin/pip"
    FileUtils.cp "#{CREW_PREFIX}/bin/pip3", "#{CREW_PREFIX}/bin/pip"
  end
end
