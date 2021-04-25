require 'package'

class Python2 < Package
  description 'Python is a programming language that lets you work quickly and integrate systems more effectively.'
  homepage 'https://www.python.org/'
  version '2.7.18'
  license 'custom'
  compatibility 'all'
  source_url 'https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tar.xz'
  source_sha256 'b62c0e7937551d0cc02b8fd5cb0f544f9405bafc9a54d3808ed4594812edef43'

  depends_on 'libffi'
  depends_on 'expat'
  depends_on 'zlibpkg'
  depends_on 'bz2' => :build
  depends_on 'sqlite' => :build

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
    FileUtils.mkdir CREW_DEST_LIB_PREFIX unless Dir.exist? CREW_DEST_LIB_PREFIX
    FileUtils.mv "#{CREW_DEST_PREFIX}/lib/libpython2.7.so", CREW_DEST_LIB_PREFIX
    FileUtils.mv "#{CREW_DEST_PREFIX}/lib/libpython2.7.so.1.0", CREW_DEST_LIB_PREFIX

    # Remove python executable, python3 is default
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/python"

    # Remove other comflicting executables
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/2to3"
  end
end
