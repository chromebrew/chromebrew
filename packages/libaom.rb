require 'package'

class Libaom < Package
  description 'AV1 video codec from Alliance for Open Media'
  homepage 'https://aomedia.org/'
  version '3.12.1'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://aomedia.googlesource.com/aom.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '54083b99311194c9ec94abc1a4419aed309dd3476511c92269dc3d43d5f064aa',
     armv7l: '54083b99311194c9ec94abc1a4419aed309dd3476511c92269dc3d43d5f064aa',
       i686: 'b7e7b58fe43d248a81b5222dc6bd5eb09f424cdb3198fd094a07c97c321d2590',
     x86_64: '7db4dda7d5351b8bf9c5d08f28439d99e779ea715740788490d2199f30ec719e'
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
