require 'package'

class Python2 < Package
  description 'Python is a programming language that lets you work quickly and integrate systems more effectively.'
  homepage 'https://www.python.org/'
  version '2.7.18-1'
  license 'custom'
  compatibility 'all'
  source_url 'https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tar.xz'
  source_sha256 'b62c0e7937551d0cc02b8fd5cb0f544f9405bafc9a54d3808ed4594812edef43'

  depends_on 'bz2' # R
  depends_on 'expat' # R
  depends_on 'glibc' # R
  depends_on 'libdb' # R
  depends_on 'libffi' # R
  depends_on 'ncurses' # R
  depends_on 'openssl' # R
  depends_on 'readline' # R
  depends_on 'sqlite' # R
  depends_on 'zlibpkg' # R

  def self.prebuild
    # Ensure that internal copies of expat, libffi and zlib aren't used
    FileUtils.rm_rf [ 'Modules/expat', 'Modules/zlib', *Dir['Modules/_ctypes/libffi*', 'Modules/_ctypes/darwin*'] ]
  end

  def self.build
    system CREW_ENV_OPTIONS_HASH.merge({
      'TMPDIR' => "#{CREW_PREFIX}/tmp",  # Using /tmp breaks tests
      'CC' => 'clang -Wno-unused-command-line-argument -Wno-ignored-optimization-argument', # use clang for faster build
      'CXX' => 'clang++ -Wno-unused-command-line-argument -Wno-ignored-optimization-argument',
      'AR' => 'llvm-ar',
      'NM' => 'llvm-nm',
      'RANLIB' => 'llvm-ranlib'
    }), <<~BUILD
      ./configure #{CREW_OPTIONS} \
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
        --enable-shared
    BUILD
    system({ 'TMPDIR' => "#{CREW_PREFIX}/tmp" }, 'make')
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'

    # Remove executable symlinks, python3 is default
    FileUtils.rm [ "#{CREW_DEST_PREFIX}/bin/python", "#{CREW_DEST_PREFIX}/bin/2to3" ]
  end
end
