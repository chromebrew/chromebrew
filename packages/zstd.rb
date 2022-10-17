require 'package'

class Zstd < Package
  description 'Zstandard - Fast real-time compression algorithm'
  homepage 'http://www.zstd.net'
  @_ver = '1.5.2'
  version "#{@_ver}-1"
  license 'BSD or GPL-2'
  compatibility 'all'
  source_url 'https://github.com/facebook/zstd.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zstd/1.5.2-1_armv7l/zstd-1.5.2-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zstd/1.5.2-1_armv7l/zstd-1.5.2-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zstd/1.5.2-1_i686/zstd-1.5.2-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zstd/1.5.2-1_x86_64/zstd-1.5.2-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'd8b71760987ab2836e98fd2d8819cbaa95402e88cd9718f0de23f777140c4d7e',
     armv7l: 'd8b71760987ab2836e98fd2d8819cbaa95402e88cd9718f0de23f777140c4d7e',
       i686: '6e159bb381c0b5595714d875e486348a05166332056ce2bc4c3f997a2652a93d',
     x86_64: 'b04d97b3d328f8c0805e2fcee0526b1e955255ca21ceaed6f6e1fb8e6941b312'
  })

  depends_on 'glibc' # R
  depends_on 'musl_zstd'
  no_patchelf
  no_zstd

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
