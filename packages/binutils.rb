require 'package'

class Binutils < Package
  description 'The GNU Binutils are a collection of binary tools.'
  homepage 'https://www.gnu.org/software/binutils/'
  @_ver = '2.39'
  version @_ver
  license 'GPL-3+'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/binutils/binutils-#{@_ver}.tar.xz"
  source_sha256 '645c25f563b8adc0a81dbd6a41cffbf4d37083a382e02d5d3df4f65c09516d00'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/binutils/2.39_armv7l/binutils-2.39-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/binutils/2.39_armv7l/binutils-2.39-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/binutils/2.39_i686/binutils-2.39-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/binutils/2.39_x86_64/binutils-2.39-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8432ae6977b5cb0bac2a197cb20372652ac218d37ccf1f3b2eaa2994498f792d',
     armv7l: '8432ae6977b5cb0bac2a197cb20372652ac218d37ccf1f3b2eaa2994498f792d',
       i686: '43a6b790fb88e7f4458816115e58f58ca3e90233c740ffd736cabbac52ce7cdf',
     x86_64: '441b6efece778075bf55b36b70a42379d2bd3ae056bf8a6edef5ea6989cdc95d'
  })

  depends_on 'flex'

  def self.prebuild
    FileUtils.rm_f "#{CREW_LIB_PREFIX}/libiberty.a"
  end

  def self.patch
    system 'filefix'
    system "sed -i 's,scriptdir = $(tooldir)/lib,scriptdir = $(tooldir)/#{ARCH_LIB},g' ld/Makefile.am"
    Dir.chdir 'ld' do
      system 'aclocal && automake'
    end
  end

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "../configure #{CREW_OPTIONS} \
        --disable-bootstrap \
        --disable-maintainer-mode \
        --enable-64-bit-bfd \
        --enable-gold=default \
        --enable-install-libiberty \
        --enable-ld \
        --enable-lto \
        --enable-plugins \
        --enable-relro \
        --enable-shared \
        --enable-threads \
        --enable-vtable-verify \
        --with-bugurl=https://github.com/chromebrew/chromebrew/issues/new \
        --with-lib-path=#{CREW_LIB_PREFIX} \
        --with-pic \
        --with-pkgversion=Chromebrew \
        --with-system-zlib"
      system 'make configure-host'
      system "make tooldir=#{CREW_PREFIX}"
    end
  end

  def self.check
    Dir.chdir 'build' do
      system 'make check || true'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", "prefix=#{CREW_PREFIX}",
             "tooldir=#{CREW_PREFIX}", 'install'
    end
  end
end
