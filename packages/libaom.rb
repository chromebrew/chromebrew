require 'package'

class Libaom < Package
  description 'AV1 video codec from Alliance for Open Media'
  homepage 'https://aomedia.org/'
  version '3.14.1'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://aomedia.googlesource.com/aom.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c91cff80d678af97d7942193cc6dd55e9d7431242a2fbbe4e1d3529dd8d255be',
     armv7l: 'c91cff80d678af97d7942193cc6dd55e9d7431242a2fbbe4e1d3529dd8d255be',
       i686: '998be31f0716369763a595eb65d62195706f9ce74298ce94f9c816e9bf2c58b8',
     x86_64: 'f05c9eb07e66a42ce0954806e24c0e1cffd76e5a00b8f4fd24e53ba87805c1d5'
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
