require 'package'

class Python3 < Package
  description 'Python is a programming language that lets you work quickly and integrate systems more effectively.'
  homepage 'https://www.python.org/'
  @_ver = '3.10.8'
  version @_ver
  license 'PSF-2.0'
  compatibility 'all'
  source_url "https://www.python.org/ftp/python/#{@_ver}/Python-#{@_ver}.tar.xz"
  source_sha256 '6a30ecde59c47048013eb5a658c9b5dec277203d2793667f578df7671f7f03f3'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/python3/3.10.8_armv7l/python3-3.10.8-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/python3/3.10.8_armv7l/python3-3.10.8-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/python3/3.10.8_i686/python3-3.10.8-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/python3/3.10.8_x86_64/python3-3.10.8-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'bf1dae49145360157092f9843c43da8223a47cd5a7ca1b87a3c01e189a4eb288',
     armv7l: 'bf1dae49145360157092f9843c43da8223a47cd5a7ca1b87a3c01e189a4eb288',
       i686: '41a9de83c568c1c624964fcd588971cbfa1edcbaf4055a18830ab010e450d2b6',
     x86_64: '4f168cd30e620ca2bbc12493130a564d678623938694a133e9bfa9b165a211b5'
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
  depends_on 'mpdecimal' # R
  depends_on 'ncurses' # R
  depends_on 'openssl' # R
  depends_on 'readline' # R
  depends_on 'sqlite' # R
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R
  # depends_on 'tcl' # Needed for tkinter support
  # depends_on 'tk'  # Needed for tkinter support
  depends_on 'util_linux' # R
  no_env_options

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
    # Using /tmp breaks test_distutils, test_subprocess.
    # Proxy setting breaks test_httpservers, test_ssl,
    # test_urllib, test_urllib2, test_urllib2_localnet.
    # So, modifying environment variable to make pass tests.

    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system CREW_ENV_OPTIONS_HASH.transform_values { |v| "#{v} #{@cppflags}" }, "../configure #{CREW_OPTIONS} \
        --with-computed-gotos \
        --enable-loadable-sqlite-extensions \
        --without-ensurepip \
        --enable-optimizations \
        --with-platlibdir='lib#{CREW_LIB_SUFFIX}' \
        --with-system-ffi \
        --with-system-expat \
        --with-system-libmpdec \
        --with-libc= \
        --enable-shared"
      system 'mold -run make'
    end
  end

  def self.check
    # Chromebooks do not allow SIGHUP, so disable SIGHUP test
    system 'sed', '-i', 'Lib/test/test_asyncio/test_events.py', '-e', "/Don't have SIGHUP/s/win32/linux/"
    system 'sed', '-i', 'Lib/test/test_asyncio/test_subprocess.py', '-e', "/Don't have SIGHUP/s/win32/linux/"

    # Chromebooks return EINVAL for F_NOTIFY DN_MULTISHOT, so disable test_fcntl_64_bit
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

    # Remove conflicting binaries
    FileUtils.rm_f "#{CREW_DEST_PREFIX}/bin/wheel"

    # Make python3 the default python
    FileUtils.ln_sf 'python3', "#{CREW_DEST_PREFIX}/bin/python"
  end
end
