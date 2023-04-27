require 'package'

class Brotli < Package
  description 'Brotli compression format'
  homepage 'https://github.com/google/brotli'
  version '1.0.9-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/google/brotli/archive/v1.0.9.tar.gz'
  source_sha256 'f9e8d81d0405ba66d181529af42a3354f838c939095ff99930da6aa9cdf6fe46'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/brotli/1.0.9-1_armv7l/brotli-1.0.9-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/brotli/1.0.9-1_armv7l/brotli-1.0.9-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/brotli/1.0.9-1_i686/brotli-1.0.9-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/brotli/1.0.9-1_x86_64/brotli-1.0.9-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3014108b4923fb7efe98a2345bb1da030d1ad2dee9b316760f755a82ad6cc614',
     armv7l: '3014108b4923fb7efe98a2345bb1da030d1ad2dee9b316760f755a82ad6cc614',
       i686: 'e8e50b2df3a6b6abda7c427cd3d755ae626678bedc6dc8b2da6ab842a3cfe4dd',
     x86_64: 'd6dddc958a0fcae5b08ae0fa506aea35076d0b3e1fc329c6f0da4998b1c97671'
  })

  depends_on 'glibc' # R

  def self.patch
    # Fixes issue with newer gcc
    # https://github.com/google/brotli/issues/836
    downloader 'https://patch-diff.githubusercontent.com/raw/google/brotli/pull/838.diff',
               '7e3113676bb8b632316a339232e3c92b2c0fa025782f2fcc45c2acb305b812d8'
    system 'patch -Np1 -i 838.diff'
  end

  def self.build
    system "cmake -B builddir #{CREW_CMAKE_OPTIONS} \
      -G Ninja"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    Dir.chdir CREW_DEST_LIB_PREFIX.to_s do
      @brotlilibs = %w[libbrotlidec libbrotlienc libbrotlicommon]
      @brotlilibs.each do |lib|
        FileUtils.ln_s "#{lib}-static.a", "#{lib}.a"
      end
    end
  end
end
