require 'package'

class Musl_c_ares < Package
  description 'c-ares is a C library for asynchronous DNS requests (including name resolves).'
  homepage 'https://c-ares.haxx.se/'
  version '1.18.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://c-ares.haxx.se/download/c-ares-1.18.1.tar.gz'
  source_sha256 '1a7d52a8a84a9fbffb1be9133c0f6e17217d91ea5a6fa61f6b4729cda78ebbcf'
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: 'c93e3a4f64cd4e667369de02eddf7f524c2828a68ed3d8fe3cd695647527cddd',
     armv7l: 'c93e3a4f64cd4e667369de02eddf7f524c2828a68ed3d8fe3cd695647527cddd',
       i686: '87f32259ad3ce220d75b89e481102dcf376d8fc022fd3a577bbdc93c44d219f5',
     x86_64: '9775556215c5a09423c36f61a902d0510ba8ad68865d26c48c3fbe02af62a23c'
  })

  depends_on 'musl_native_toolchain' => :build
  depends_on 'musl_libunistring' => :build
  depends_on 'musl_libidn2' => :build
  depends_on 'musl_zlib' => :build
  depends_on 'musl_ncurses' => :build
  depends_on 'musl_openssl' => :build
  depends_on 'musl_krb5' => :build
  depends_on 'patchelf' => :build

  is_static

  def self.build
    load "#{CREW_LIB_PATH}/lib/musl.rb"
    FileUtils.mkdir('builddir')
    Dir.chdir('builddir') do
      system "#{MUSL_CMAKE_OPTIONS} \
      -DOPENSSL_INCLUDE_DIR=#{CREW_MUSL_PREFIX}/include \
      -DCARES_STATIC=ON \
      -DCARES_STATIC_PIC=ON \
      -DCARES_BUILD_TESTS=ON \
      -DCARES_BUILD_CONTAINER_TESTS=ON \
      -DCARES_BUILD_TOOLS=ON \
      -DCARES_SHARED=OFF \
      ../ -G Ninja"
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
    Dir.chdir "#{CREW_DEST_MUSL_PREFIX}/bin/" do
      Dir.glob('*').each do |f|
        system "patchelf --set-interpreter #{CREW_MUSL_PREFIX}/lib/libc.so #{f}"
      end
    end
  end
end
