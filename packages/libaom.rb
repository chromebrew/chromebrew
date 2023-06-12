require 'package'

class Libaom < Package
  description 'AV1 video codec from Alliance for Open Media'
  homepage 'https://aomedia.org/'
  version '3.6.1'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://aomedia.googlesource.com/aom.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libaom/3.6.1_armv7l/libaom-3.6.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libaom/3.6.1_armv7l/libaom-3.6.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libaom/3.6.1_i686/libaom-3.6.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libaom/3.6.1_x86_64/libaom-3.6.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '54083b99311194c9ec94abc1a4419aed309dd3476511c92269dc3d43d5f064aa',
     armv7l: '54083b99311194c9ec94abc1a4419aed309dd3476511c92269dc3d43d5f064aa',
       i686: '6a8681ae79e7e5c3674e9ad4460bcc8bf7efb0e3cb956d931b3cca53e6417cc3',
     x86_64: '3e161e4d2759a9420486c062fedeb063b6dcf6bc4be59e7d6d7e31f453dd2014'
  })

  depends_on 'nasm' => :build
  depends_on 'glibc' # R
  depends_on 'gcc_lib' # R
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
      -Wno-dev"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
