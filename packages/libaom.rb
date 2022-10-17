require 'package'

class Libaom < Package
  description 'AV1 video codec from Alliance for Open Media'
  homepage 'https://aomedia.org/'
  version '3.5.0'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://aomedia.googlesource.com/aom.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libaom/3.5.0_armv7l/libaom-3.5.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libaom/3.5.0_armv7l/libaom-3.5.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libaom/3.5.0_i686/libaom-3.5.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libaom/3.5.0_x86_64/libaom-3.5.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'de52b8db47bade9cc3862f66e9b925d7b402f277eba3dde4cc947b170387518a',
     armv7l: 'de52b8db47bade9cc3862f66e9b925d7b402f277eba3dde4cc947b170387518a',
       i686: '8883ff0962eb09fc19361b650ce19eb42d6f3c3a8bab1935bf74ca4552bf9772',
     x86_64: '9d0a836a2ea213123c07ebee709473673b2451e77e69a7b2652bcdbf0eaa7208'
  })

  depends_on 'nasm' => :build
  depends_on 'glibc' # R

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
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
        -Wno-dev \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
