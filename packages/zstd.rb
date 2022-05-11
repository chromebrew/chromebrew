require 'package'

class Zstd < Package
  description 'Zstandard - Fast real-time compression algorithm'
  homepage 'http://www.zstd.net'
  @_ver = '1.5.2'
  version @_ver
  license 'BSD or GPL-2'
  compatibility 'all'
  source_url 'https://github.com/facebook/zstd.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zstd/1.5.2_armv7l/zstd-1.5.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zstd/1.5.2_armv7l/zstd-1.5.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zstd/1.5.2_i686/zstd-1.5.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zstd/1.5.2_x86_64/zstd-1.5.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'dcf0cc629f47f5e7ce23ef73948a859bdc8383b542ed6f6eb7689ced2541280a',
     armv7l: 'dcf0cc629f47f5e7ce23ef73948a859bdc8383b542ed6f6eb7689ced2541280a',
       i686: 'f2f95e2d6855b4591c8defe17f2e738d2cb6140af0245f005aa7889addba055f',
     x86_64: '6829742f7ba7362ad22539c914ec114acfd52d78f755f5c057902e2924dbef1f'
  })

  depends_on 'musl_zstd'
  no_patchelf

  def self.build
    Dir.chdir 'build/cmake' do
      FileUtils.mkdir('builddir')
      Dir.chdir('builddir') do
        system "cmake #{CREW_CMAKE_OPTIONS} \
        -DZSTD_BUILD_STATIC=ON \
        -DZSTD_BUILD_SHARED=ON \
        -DZSTD_LEGACY_SUPPORT=ON \
        -DZSTD_BUILD_CONTRIB=ON \
        -DZSTD_PROGRAMS_LINK_SHARED=OFF \
        ../ -G Ninja"
      end
      system 'samu -C builddir'
    end
  end

  def self.install
    Dir.chdir 'build/cmake' do
      system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
    end
    # Convert symlinks to hard links in libdir.
    Dir.chdir CREW_DEST_LIB_PREFIX do
      system "find -type l -exec bash -c 'ln -f \"\$(readlink -m \"\$0\")\" \"\$0\"' {} \\\;"
    end
  end
end
