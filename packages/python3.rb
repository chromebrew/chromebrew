require 'package'

class Python3 < Package
  description 'Python is a programming language that lets you work quickly and integrate systems more effectively.'
  homepage 'https://www.python.org/'
  @_ver = '3.9.6'
  version @_ver
  license 'PSF-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://www.python.org/ftp/python/#{@_ver}/Python-#{@_ver}.tar.xz"
  source_sha256 '397920af33efc5b97f2e0b57e91923512ef89fc5b3c1d21dbfc8c4828ce0108a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/python3/3.9.6_armv7l/python3-3.9.6-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/python3/3.9.6_armv7l/python3-3.9.6-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/python3/3.9.6_x86_64/python3-3.9.6-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '6196100c5fef60f2442e3ccebe2887ef6634fe003a9e175d6656715c77b8badf',
     armv7l: '6196100c5fef60f2442e3ccebe2887ef6634fe003a9e175d6656715c77b8badf',
     x86_64: '89f63f5bacddc09303e7bded741dad40d07db8eda6a12a568bcb4eb4ce63c036'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'krb5' => :build
  depends_on 'libtirpc' => :build
  depends_on 'bz2' # R
  depends_on 'expat' # R
  depends_on 'gdbm' # R
  depends_on 'glibc' # R
  depends_on 'libdb' # R
  depends_on 'libffi' # R
  depends_on 'ncurses' # R
  depends_on 'openssl' # R
  depends_on 'readline' # R
  depends_on 'sqlite' # R
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R
  # depends_on 'tcl' # Needed for tkinter support
  # depends_on 'tk'  # Needed for tkinter support

  def self.patch
    system "sed -i -e 's:#{CREW_LIB_PREFIX}:\$(get_libdir):g' \
		Lib/distutils/command/install.py \
		Lib/distutils/sysconfig.py \
		Lib/site.py \
		Lib/sysconfig.py \
		Lib/test/test_site.py \
		Makefile.pre.in \
		Modules/getpath.c \
		setup.py"
  end

  def self.prebuild
    # Ensure that internal copies of expat, libffi and zlib aren't used
    FileUtils.rm_rf 'Modules/expat'
    FileUtils.rm_rf Dir.glob('Modules/_ctypes/libffi*')
    FileUtils.rm_rf 'Modules/zlib'
  end

  def self.build
    @cppflags = "-I#{CREW_PREFIX}/include/ncursesw"
    # python requires /usr/local/lib, so leave as is but specify -rpath
    @ldflags = "-Wl,-rpath,-L#{CREW_LIB_PREFIX}"

    # CREW_ENV_OPTIONS don't work so we have to make our own
    @py_common_flags = "'-Os -pipe -fuse-ld=gold'"

    # Using /tmp breaks test_distutils, test_subprocess.
    # Proxy setting breaks test_httpservers, test_ssl,
    # test_urllib, test_urllib2, test_urllib2_localnet.
    # So, modifying environment variable to make pass tests.

    system 'autoreconf -fiv'
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env CFLAGS=#{@py_common_flags} CXXFLAGS=#{@py_common_flags} \
        CC='#{CREW_TGT}-gcc -pthread' \
        CXX='#{CREW_TGT}-g++' \
        CPPFLAGS='#{@cppflags}' \
        LDFLAGS='#{@ldflags} -lpthread' \
      ../configure #{CREW_OPTIONS} \
        --with-computed-gotos \
        --with-loadable-sqlite-extensions \
        --without-ensurepip \
        --enable-optimizations \
        --with-lto \
        --with-platlibdir='lib#{CREW_LIB_SUFFIX}' \
        --with-system-ffi \
        --with-system-expat \
        --with-system-libmpdev \
        --enable-shared"
      system 'make'
    end
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
    # system "http_proxy= https_proxy= ftp_proxy= make test"
  end

  def self.install
    Dir.chdir 'builddir' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end

    # remove static libraries
    # system "find #{CREW_DEST_PREFIX} -name 'libpython*.a' -print | xargs -r rm"

    # create symbolic links in lib64 for other applications which use libpython
    # Not needed as --libdir is passed to ./configure
    # unless Dir.exist? CREW_DEST_LIB_PREFIX
    #  FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
    #  system "cd #{CREW_DEST_LIB_PREFIX} && ln -s ../lib/libpython*.so* ."
    # end

    # Remove conflicting binaries
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/wheel" if File.exist? "#{CREW_DEST_PREFIX}/bin/wheel"

    # Make python3 the default python
    FileUtils.ln_sf 'python3', "#{CREW_DEST_PREFIX}/bin/python"
  end
end
