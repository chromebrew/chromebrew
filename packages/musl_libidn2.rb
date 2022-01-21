require 'package'

class Musl_libidn2 < Package
  description 'GNU Libidn is a fully documented implementation of the Stringprep, Punycode and IDNA 2003 specifications.'
  homepage 'https://www.gnu.org/software/libidn/'
  @_ver = '2.3.2'
  version "#{@_ver}-1"
  license 'GPL-2+ and LGPL-3+'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/libidn/libidn2-#{@_ver}.tar.gz"
  source_sha256 '76940cd4e778e8093579a9d195b25fff5e936e9dc6242068528b437a76764f91'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libidn2/2.3.2-1_armv7l/musl_libidn2-2.3.2-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libidn2/2.3.2-1_armv7l/musl_libidn2-2.3.2-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libidn2/2.3.2-1_i686/musl_libidn2-2.3.2-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libidn2/2.3.2-1_x86_64/musl_libidn2-2.3.2-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'fd3f74482aebcf9897c618eb74c45e6512ff77524f3f6135029ad7e746e5ecbe',
     armv7l: 'fd3f74482aebcf9897c618eb74c45e6512ff77524f3f6135029ad7e746e5ecbe',
       i686: '45c0aa8e6cac6846789851ae08a06d0f7165fbfe0ef8c8c3a331befa2d00edb9',
     x86_64: '9919fe30f0b8710388e874a7289664a4867dae54b3bf2bbd494eecf92ebb8ac4'
  })

  depends_on 'musl_native_toolchain' => :build
  depends_on 'musl_libunistring' => :build
  depends_on 'musl_zlib' => :build

  is_static

  def self.patch
    FileUtils.rm_f 'doc/idn2.1'
  end

  def self.build
    load "#{CREW_LIB_PATH}lib/musl.rb"
    system "#{MUSL_ENV_OPTIONS} ./configure --prefix=#{CREW_MUSL_PREFIX} \
        --disable-shared \
        --disable-doc \
        --disable-rpath \
        --disable-gtk-doc \
        --disable-gtk-doc-pdf"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
