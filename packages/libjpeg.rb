require 'package'

class Libjpeg < Package
  description 'Libjpeg-turbo implements both the traditional libjpeg API as well as the less powerful but more straightforward TurboJPEG API.'
  homepage 'https://libjpeg-turbo.org'
  version '3.0.0'
  compatibility 'all'
  source_url 'https://github.com/libjpeg-turbo/libjpeg-turbo.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjpeg/3.0.0_armv7l/libjpeg-3.0.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjpeg/3.0.0_armv7l/libjpeg-3.0.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjpeg/3.0.0_i686/libjpeg-3.0.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjpeg/3.0.0_x86_64/libjpeg-3.0.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9b10ba35f72b7ba00f114b794d6095accdcaf6485423f674e8bba7c974464aa4',
     armv7l: '9b10ba35f72b7ba00f114b794d6095accdcaf6485423f674e8bba7c974464aa4',
       i686: '515a751b7160bddbc085de6b47df1503148ec1d76f527ae12fa4c9229992da8d',
     x86_64: '0d26e82b4ff505b042d9928f0912046fcf4010671e0fbb81509e609eb12b6eb9'
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
