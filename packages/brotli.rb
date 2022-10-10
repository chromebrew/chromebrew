require 'package'

class Brotli < Package
  description 'Brotli compression format'
  homepage 'https://github.com/google/brotli'
  version '1.0.9'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/google/brotli/archive/v1.0.9.tar.gz'
  source_sha256 'f9e8d81d0405ba66d181529af42a3354f838c939095ff99930da6aa9cdf6fe46'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/brotli/1.0.9_armv7l/brotli-1.0.9-chromeos-armv7l.tpxz',
    armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/brotli/1.0.9_armv7l/brotli-1.0.9-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/brotli/1.0.9_i686/brotli-1.0.9-chromeos-i686.tpxz',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/brotli/1.0.9_x86_64/brotli-1.0.9-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5346decd05692836b92056ecddbd530ce4b8c741f4b8903104a0495f0b44b590',
    armv7l: '5346decd05692836b92056ecddbd530ce4b8c741f4b8903104a0495f0b44b590',
    i686: '2e0214bd69b04c9deb8af703c21ccca71c98462fcad81c7664608376e926af27',
    x86_64: '04cabaaf97a633c2ffe1de7ebc74dd4227f60e1dc1e69bd6094fe69e38020cb4'
  })

  depends_on 'glibc' # R

  def self.build
    FileUtils.mkdir('builddir')
    Dir.chdir('builddir') do
      system "cmake #{CREW_CMAKE_OPTIONS} \
      ../ -G Ninja"
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    Dir.chdir CREW_DEST_LIB_PREFIX.to_s do
      @brotlilibs = %w[libbrotlidec libbrotlienc libbrotlicommon]
      @brotlilibs.each do |lib|
        FileUtils.ln_s "#{lib}-static.a", "#{lib}.a"
      end
    end
  end
end
