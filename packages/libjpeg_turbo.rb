require 'package'

class Libjpeg_turbo < Package
  description 'Libjpeg-turbo implements both the traditional libjpeg API as well as the less powerful but more straightforward TurboJPEG API.'
  homepage 'https://libjpeg-turbo.org'
  version '3.0.3'
  license 'IJG License'
  compatibility 'all'
  source_url 'https://github.com/libjpeg-turbo/libjpeg-turbo.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a310b3d08d0ab8c669a4131c2a0d585c3c72bf4a483d198b78f77e7690320a34',
     armv7l: 'a310b3d08d0ab8c669a4131c2a0d585c3c72bf4a483d198b78f77e7690320a34',
       i686: 'c950ec0f49c9963ee2f3fb360ca114eac28a0cc2b08de015091ef06f7156502d',
     x86_64: '0bf918eaaf48bf316ab223740bb7e036552b422872e907d40c48b3ef44ed9963'
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
