require 'package'

class Python3 < Package
  description 'Python is a programming language that lets you work quickly and integrate systems more effectively.'
  homepage 'https://www.python.org/'
  @_ver = '3.11.0'
  version @_ver
  license 'PSF-2.0'
  compatibility 'all'
  source_url "https://www.python.org/ftp/python/#{@_ver}/Python-#{@_ver}.tar.xz"
  source_sha256 'a57dc82d77358617ba65b9841cee1e3b441f386c3789ddc0676eca077f2951c3'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/python3/3.11.0_armv7l/python3-3.11.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/python3/3.11.0_armv7l/python3-3.11.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/python3/3.11.0_i686/python3-3.11.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/python3/3.11.0_x86_64/python3-3.11.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '45af8d33fe7d419c83a1cb829e318cc97f6de6a78d522845f52829ee9642ea41',
     armv7l: '45af8d33fe7d419c83a1cb829e318cc97f6de6a78d522845f52829ee9642ea41',
       i686: '2d07bfb72df0a579b0854c02ba1d9a32264ad2e149e4a0f5a1b26622010cb2b7',
     x86_64: '87cab9510346a3061cab055f6b071931ff79f5479c75d7875530a124e9004ede'
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
  conflicts_ok

  def self.preinstall
    @device = JSON.load_file("#{CREW_CONFIG_PATH}/device.json", symbolize_names: true)
    @replaces = %w[py3_pip py3_setuptools]
    @replaces_installed = []
    @replaces.each do |package|
      if @device[:installed_packages].any? { |elem| elem[:name] == package }
        @replaces_installed.push(package)
      end
    end
    unless @replaces_installed.empty?
      puts "Removing superseded package(s): #{@replaces_installed.join(' ')}...".orange
      system "crew remove #{@replaces_installed.join(' ')}", exception: false
    end
  end

  def self.patch
    system "sed -i -e 's:#{CREW_LIB_PREFIX}:$(get_libdir):g' \
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

    FileUtils.mkdir_p 'builddir'
    Dir.chdir 'builddir' do
      system CREW_ENV_OPTIONS_HASH.transform_values { |v| "#{v} #{@cppflags}" }, "../configure #{CREW_OPTIONS} \
        --with-computed-gotos \
        --enable-loadable-sqlite-extensions \
        --with-ensurepip \
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

    # Make python3 the default python
    FileUtils.ln_sf 'python3', "#{CREW_DEST_PREFIX}/bin/python"
  end

  def self.postinstall
    system 'pip3 install --upgrade pip'
  end
end
