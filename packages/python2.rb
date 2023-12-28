require 'package'

class Python2 < Package
  description 'Python is a programming language that lets you work quickly and integrate systems more effectively.'
  homepage 'https://www.python.org/'
  version '2.7.18'
  license 'custom'
  compatibility 'all'
  source_url 'https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tar.xz'
  source_sha256 'b62c0e7937551d0cc02b8fd5cb0f544f9405bafc9a54d3808ed4594812edef43'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/python2/2.7.18_armv7l/python2-2.7.18-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/python2/2.7.18_armv7l/python2-2.7.18-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/python2/2.7.18_i686/python2-2.7.18-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/python2/2.7.18_x86_64/python2-2.7.18-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '8d50eb96aac259934a8a057280244ca4a7f312cee4a331694890ea7ac4d757c7',
     armv7l: '8d50eb96aac259934a8a057280244ca4a7f312cee4a331694890ea7ac4d757c7',
       i686: 'bb74dd4cc2f10a30b861b41ccbc14e7251e4838d288a033e72ce502376247bc8',
     x86_64: 'b733a3aa7b34b2737cc1cc433e3fe2ddb99c014837268fde3b5697f79da2510c'
  })

  depends_on 'bzip2' # R
  depends_on 'expat' # R
  depends_on 'glibc' # R
  depends_on 'libdb' # R
  depends_on 'libffi' # R
  depends_on 'ncurses' # R
  depends_on 'openssl' # R
  depends_on 'readline' # R
  depends_on 'sqlite' # R
  depends_on 'zlibpkg' # R

  #  def self.patch
  #    system "sed -i -e 's:#{CREW_LIB_PREFIX}:$(get_libdir):g' \
  #		Lib/distutils/command/install.py \
  #		Lib/distutils/sysconfig.py \
  #		Lib/site.py \
  #		Lib/sysconfig.py \
  #		Lib/test/test_site.py \
  #		Makefile.pre.in \
  #		Modules/Setup.dist \
  #		Modules/getpath.c \
  #		setup.py"
  #  end

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
        CC='#{CREW_TGT}-gcc' \
        CXX='#{CREW_TGT}-g++' \
        CPPFLAGS='#{@cppflags}' \
        LDFLAGS='#{@ldflags}' \
      ../configure --prefix=#{CREW_PREFIX} --build=#{CREW_BUILD} --host=#{CREW_TGT} --target=#{CREW_TGT} \
            --with-fpectl \
            --enable-ipv6 \
            --with-threads \
            --enable-unicode=ucs4 \
            --with-computed-gotos \
            --with-loadable-sqlite-extensions \
            --without-ensurepip \
            --enable-optimizations \
            --with-lto \
            --with-system-ffi \
            --with-system-expat \
            --enable-shared"
      system 'make'
    end
  end

  def self.check
    # system "http_proxy= https_proxy= ftp_proxy= make test"
  end

  def self.install
    Dir.chdir 'builddir' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end

    # remove static libraries
    # system "find #{CREW_DEST_PREFIX} -name 'libpython*.a' -print | xargs -r rm"

    # move dynamic libraries to their correct places, so the dynamic loader can find them
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
    FileUtils.mv "#{CREW_DEST_PREFIX}/lib/libpython2.7.so", CREW_DEST_LIB_PREFIX unless CREW_LIB_SUFFIX.empty?
    FileUtils.mv "#{CREW_DEST_PREFIX}/lib/libpython2.7.so.1.0", CREW_DEST_LIB_PREFIX unless CREW_LIB_SUFFIX.empty?

    # Remove python executable, python3 is default
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/python"

    # Remove other comflicting executables
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/2to3"
  end
end
