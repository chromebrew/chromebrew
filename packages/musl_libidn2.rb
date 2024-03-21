require 'package'

class Musl_libidn2 < Package
  description 'GNU Libidn is a fully documented implementation of the Stringprep, Punycode and IDNA 2003 specifications.'
  homepage 'https://www.gnu.org/software/libidn/'
  @_ver = '2.3.2'
  version "#{@_ver}-3"
  license 'GPL-2+ and LGPL-3+'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/libidn/libidn2-#{@_ver}.tar.gz"
  source_sha256 '76940cd4e778e8093579a9d195b25fff5e936e9dc6242068528b437a76764f91'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1416d175baa8d27371ad680e92b014874aa19dafc1758ae217ae1e5a24210b32',
     armv7l: '1416d175baa8d27371ad680e92b014874aa19dafc1758ae217ae1e5a24210b32',
       i686: 'a301977e5cc8e3fe50a0c400740f6f2520bfdadcb30d800609a56f2ddfc1bd52',
     x86_64: '8a53313e0858042a96a656749fbcd50d18627c71bffa86c254858334503b844c'
  })

  depends_on 'musl_native_toolchain' => :build
  depends_on 'musl_libunistring' => :build
  depends_on 'musl_zlib' => :build

  is_musl
  is_static
  patchelf

  def self.patch
    FileUtils.rm_f 'doc/idn2.1'
  end

  def self.build
    system "#{MUSL_ENV_OPTIONS} ./configure --prefix=#{CREW_MUSL_PREFIX} \
        --enable-static \
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
