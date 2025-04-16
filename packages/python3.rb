require 'package'

class Python3 < Package
  description 'Python is a programming language that lets you work quickly and integrate systems more effectively.'
  homepage 'https://www.python.org/'
  version '3.13.3'
  license 'PSF-2.0'
  compatibility 'all'
  source_url "https://www.python.org/ftp/python/#{version}/Python-#{version}.tar.xz"
  source_sha256 '40f868bcbdeb8149a3149580bb9bfd407b3321cd48f0be631af955ac92c0e041'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '877455d39115d2b22d706615d229cbee6f70c286bb5aa1c6dba8ee8e63eace56',
     armv7l: '877455d39115d2b22d706615d229cbee6f70c286bb5aa1c6dba8ee8e63eace56',
       i686: '08f190307885f5c51412baa6dc621538f9a288c795a958cbb17c7cf8ce98c523',
     x86_64: '4f06de7d9a546301339538bf58a147321e87a6cc24c6faa5a92ae9cb0b648256'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'bzip2' # R
  depends_on 'expat' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdbm' # R
  depends_on 'glibc' # R
  depends_on 'krb5' => :build
  depends_on 'libdb' # R
  depends_on 'libffi' # R
  depends_on 'mpdecimal' # R
  depends_on 'ncurses' # R
  depends_on 'openssl' # R
  depends_on 'readline' # R
  depends_on 'sqlite' # R
  depends_on 'tcl' => :build unless ARCH == 'i686' # Needed for tkinter support
  depends_on 'tk' => :build unless ARCH == 'i686' # Needed for tkinter support
  depends_on 'util_linux' # R
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zoneinfo' # L

  no_env_options
  conflicts_ok

  def self.patch
    # Skip tests which rely on not having an underlying zfs filesystem.
    # https://github.com/python/cpython/issues/125117
    # See https://github.com/python/cpython/issues/81765
    system "sed -i '/test_sqlite3/d'  Lib/test/libregrtest/pgo.py" unless %w[aarch64 armv7l].include?(ARCH)
    # Work around issue with sqlite3 3.49.x. See https://github.com/python/cpython/issues/129870
    # downloader 'https://github.com/python/cpython/commit/d26c2fe7a2833606b3fb8d9789149d8696978d86.diff', '4483a8b381254db3627889e7914bd167d8a7bbf7521217e6202103b58d3e5f33'
    # system 'patch -Np1 -i d26c2fe7a2833606b3fb8d9789149d8696978d86.diff'
  end

  def self.preinstall
    @device = JSON.load_file("#{CREW_CONFIG_PATH}/device.json", symbolize_names: true)
    @replaces = %w[py3_pip py3_setuptools]
    @replaces_installed = []
    @replaces.each do |package|
      @replaces_installed.push(package) if @device[:installed_packages].any? { |elem| elem[:name] == package }
    end
    return if @replaces_installed.empty?

    puts "Removing superseded package(s): #{@replaces_installed.join(' ')}...".orange
    system "crew remove #{@replaces_installed.join(' ')}", exception: false
  end

  def self.prebuild
    # Ensure that internal copies of expat, libffi and zlib aren't used
    # FileUtils.rm_rf 'Modules/expat'
    # FileUtils.rm_rf Dir.glob('Modules/_ctypes/libffi*')
    # FileUtils.rm_rf 'Modules/zlib'
  end

  def self.build
    # Using /tmp breaks test_distutils, test_subprocess.
    # Proxy setting breaks test_httpservers, test_ssl,
    # test_urllib, test_urllib2, test_urllib2_localnet.
    # So, modifying environment variable to make pass tests.

    return if Dir.exist?('builddir')

    FileUtils.mkdir_p 'builddir'
    Dir.chdir 'builddir' do
      system "../configure #{CREW_CONFIGURE_OPTIONS} \
          --with-lto \
          --with-computed-gotos \
          --enable-loadable-sqlite-extensions \
          --with-ensurepip \
          --enable-optimizations \
          --with-platlibdir='lib#{CREW_LIB_SUFFIX}' \
          --with-system-expat \
          --with-system-libmpdec \
          --with-tzpath=#{CREW_PREFIX}/share/zoneinfo \
          --with-libc= \
          --enable-shared"
      system "MAKEFLAGS=-j#{CREW_NPROC} mold -run make"
      File.write 'python_config_env', <<~PYTHON_CONFIG_EOF
        # Force use of python3 over python2.7 in packages which check the variable to set the python used.
        PYTHON=python3
      PYTHON_CONFIG_EOF
    end
  end

  def self.install
    Dir.chdir 'builddir' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
      # There is a Python ABI break in 3.11.5 coming from 3.11.4, see https://github.com/python/cpython/issues/108525
      system "LD_LIBRARY_PATH=#{CREW_DEST_LIB_PREFIX}:#{CREW_LIB_PREFIX} #{CREW_DEST_PREFIX}/bin/python3 -m ensurepip --upgrade --default-pip"
      system "sed -i 's,#{CREW_DEST_PREFIX}/bin/python3,#{CREW_PREFIX}/bin/python3,g' #{CREW_DEST_PREFIX}/bin/pip3"
    end

    # Make python3 the default python
    FileUtils.ln_sf 'python3', "#{CREW_DEST_PREFIX}/bin/python"
    FileUtils.ln_sf 'pip3', "#{CREW_DEST_PREFIX}/bin/pip"
    FileUtils.install 'builddir/python_config_env', "#{CREW_DEST_PREFIX}/etc/env.d/python", mode: 0o644
  end

  def self.postinstall
    # First force pip upgrade to make sure we are past the problematic pip 23.2.1
    # See https://github.com/pypa/pip/issues/12357 and https://github.com/pypa/pip/issues/12428
    system 'PIP_DISABLE_PIP_VERSION_CHECK=1 python -m pip install --upgrade --force-reinstall pip'
    # Pip is installed inside Python 3. The following steps ensure that
    # pip can properly build other packages from buildsystems/pip.
    @required_pip_modules = %w[build installer setuptools wheel pyproject_hooks]
    @pip_list = `pip list --exclude pip`
    @required_pip_modules.each do |pip_pkg|
      unless @pip_list.include?(pip_pkg)
        puts "Installing #{pip_pkg} using pip..."
        system "MAKEFLAGS=-j#{CREW_NPROC} pip install #{pip_pkg}"
      end
    end

    puts 'Updating pip packages...'.lightblue
    system 'pip list --outdated --format=json | python -c "import json, sys; print(\'\n\'.join([x[\'name\'] for x in json.load(sys.stdin)]))" | xargs -rn1 pip install -U', exception: false
    ExitMessage.add "Please install tcl and tk with 'crew install tcl tk' if tkinter is needed.".lightblue unless ARCH == 'i686'
  end
end
