require 'package'

class Musl_brotli < Package
  description 'Brotli compression format'
  homepage 'https://github.com/google/brotli'
  version '1.0.9-3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/google/brotli/archive/v1.0.9.tar.gz'
  source_sha256 'f9e8d81d0405ba66d181529af42a3354f838c939095ff99930da6aa9cdf6fe46'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2c4f045fc242e8cc58d461cd8b632c7e5748c0e26b0ab81e0509b94ba2636c9d',
     armv7l: '2c4f045fc242e8cc58d461cd8b632c7e5748c0e26b0ab81e0509b94ba2636c9d',
       i686: '3e855179333bdae4b95c6cf96406e055cbafa2919e364485ecc455aff791bde3',
     x86_64: '9426b67a46d536d0910cb384f7880e17b892100affda1baab7175929e14d7bc8'
  })

  depends_on 'musl_native_toolchain' => :build

  is_musl
  is_static
  print_source_bashrc

  def self.build
    load "#{CREW_LIB_PATH}/lib/musl.rb"
    FileUtils.mkdir('builddir')
    Dir.chdir('builddir') do
      system "#{MUSL_CMAKE_OPTIONS} \
      -DBUILD_SHARED_LIBS=OFF \
      -DWITH_STATIC_LIB=ON \
        ../ -G Ninja"
    end
    system "PATH=#{CREW_MUSL_PREFIX}/bin:#{CREW_MUSL_PREFIX}/#{ARCH}-linux-musl#{@abi}/bin:#{ENV.fetch('PATH', nil)} \
      samu -C builddir -j#{CREW_NPROC}"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
    Dir.chdir "#{CREW_DEST_MUSL_PREFIX}/lib" do
      @brotlilibs = %w[libbrotlidec libbrotlienc libbrotlicommon]
      @brotlilibs.each do |lib|
        FileUtils.ln_s "#{lib}-static.a", "#{lib}.a"
      end
    end
  end
end
