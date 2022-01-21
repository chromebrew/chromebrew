require 'package'

class Musl_brotli < Package
  description 'Brotli compression format'
  homepage 'https://github.com/google/brotli'
  version '1.0.9-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/google/brotli/archive/v1.0.9.tar.gz'
  source_sha256 'f9e8d81d0405ba66d181529af42a3354f838c939095ff99930da6aa9cdf6fe46'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_brotli/1.0.9-1_armv7l/musl_brotli-1.0.9-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_brotli/1.0.9-1_armv7l/musl_brotli-1.0.9-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_brotli/1.0.9-1_i686/musl_brotli-1.0.9-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_brotli/1.0.9-1_x86_64/musl_brotli-1.0.9-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'cc9db48c4b961fe608a7ce3e1992c13e2972dc8779127c0edc8b3a95dd76097c',
     armv7l: 'cc9db48c4b961fe608a7ce3e1992c13e2972dc8779127c0edc8b3a95dd76097c',
       i686: '57ee94d94b6e0ea798feaf49f002e3781c0e9ab6daf2795dcc9d938e9901744e',
     x86_64: '4e85283bc1ee9747495df8c37662d4e4cb9a714718509492f2317b5c08f0ee76'
  })

  depends_on 'musl_native_toolchain' => :build

  is_static

  def self.build
    load "#{CREW_LIB_PATH}lib/musl.rb"
    FileUtils.mkdir('builddir')
    Dir.chdir('builddir') do
      system "#{MUSL_CMAKE_OPTIONS} \
      -DBUILD_SHARED_LIBS=OFF \
      -DWITH_STATIC_LIB=ON \
        ../ -G Ninja"
    end
    system "PATH=#{CREW_MUSL_PREFIX}/bin:#{CREW_MUSL_PREFIX}/#{ARCH}-linux-musl#{@abi}/bin:#{ENV['PATH']} \
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
