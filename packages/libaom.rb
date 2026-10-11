require 'package'

class Libaom < Package
  description 'AV1 video codec from Alliance for Open Media'
  homepage 'https://aomedia.org/'
  version '3.15.2'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://aomedia.googlesource.com/aom.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3f8a7b6f6022e1c9a8f4cc65fd3b81cb6dc0703fcf75e3758d2d79225fb25f16',
     armv7l: '3f8a7b6f6022e1c9a8f4cc65fd3b81cb6dc0703fcf75e3758d2d79225fb25f16',
       i686: 'f3e4797c667e2723a7033120042286190e85a109270db707c4c24a0e7504439b',
     x86_64: '79c11660be9000ea5e9dd6a31969fc3179c2f2bd3039433b4b4e6aae46542ef0'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'nasm' => :build
  no_env_options

  def self.build
    system "cmake \
      -B builddir -G Ninja \
      #{CREW_CMAKE_OPTIONS.gsub('-mfpu=vfpv3-d16', '-mfpu=neon-fp16')} \
      -DBUILD_SHARED_LIBS:BOOL='ON' \
      -DCMAKE_COLOR_MAKEFILE:BOOL='ON' \
      -DENABLE_CCACHE:BOOL='OFF' \
      -DENABLE_DECODE_PERF_TESTS:BOOL='OFF' \
      -DENABLE_EXAMPLES:BOOL='ON' \
      -DENABLE_DISTCC:BOOL='OFF' \
      -DENABLE_DOCS:BOOL='ON' \
      -DENABLE_GOMA:BOOL='OFF' \
      -DENABLE_NASM:BOOL='ON' \
      -DENABLE_TESTS:BOOL='OFF' \
      -DENABLE_TOOLS:BOOL='ON' \
      -DENABLE_WERROR:BOOL='OFF' \
      -DINCLUDE_INSTALL_DIR:PATH='#{CREW_PREFIX}/include' \
      -DLIB_INSTALL_DIR:PATH='#{CREW_LIB_PREFIX}' \
      -Wno-author"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
