require 'package'

class Libaom < Package
  description 'AV1 video codec from Alliance for Open Media'
  homepage 'https://aomedia.org/'
  version '3.15.1'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://aomedia.googlesource.com/aom.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6b64e20e24391bbf142094fc71f9e0a46b14c4b3ca78c1d3c74fa7b77e8d313e',
     armv7l: '6b64e20e24391bbf142094fc71f9e0a46b14c4b3ca78c1d3c74fa7b77e8d313e',
       i686: '503d9c69657f5a6925dad3438d5a3ce1d622ba3c5e1248e5ce456f3dff105b1a',
     x86_64: '9f1ef344114ab5d0c2b5eebe074c3608f8819da7e81c04de5f205373406a5012'
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
