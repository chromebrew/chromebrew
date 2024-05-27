require 'package'

class Libjpeg_turbo < Package
  description 'Libjpeg-turbo implements both the traditional libjpeg API as well as the less powerful but more straightforward TurboJPEG API.'
  homepage 'https://libjpeg-turbo.org'
  version '3.0.1'
  license 'IJG License'
  compatibility 'all'
  source_url 'https://github.com/libjpeg-turbo/libjpeg-turbo.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a7fe8b57a528867d5ad68d931434881f2ac6fd2a3ab25f83c2ec2ca90f3d7fa9',
     armv7l: 'a7fe8b57a528867d5ad68d931434881f2ac6fd2a3ab25f83c2ec2ca90f3d7fa9',
       i686: '7864edd0f3a0fdaa898d396959b5f6f84a7a95036aa525c40886eee15fcce1dc',
     x86_64: 'f14efb6cd521be8799327fda823175f2edd2eaa42b0be05bd8b2f0c2d698cf4e'
  })

  depends_on 'yasm' => :build
  depends_on 'glibc' # R

  no_env_options

  def self.build
    system "cmake \
        -B builddir -G Ninja \
        #{CREW_CMAKE_OPTIONS.gsub('-mfpu=vfpv3-d16', '-mfpu=neon-fp16')} \
        -DENABLE_STATIC=OFF \
        -DWITH_12BIT=OFF \
        -DWITH_JAVA=OFF \
        -W no-dev"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    FileUtils.install 'jpegint.h', "#{CREW_DEST_PREFIX}/include/", mode: 0o644
  end
end
