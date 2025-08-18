require 'package'

class Leptonica < Package
  description 'Software that is broadly useful for image processing and image analysis applications'
  homepage 'http://www.leptonica.org'
  version '1.85.0'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/DanBloomberg/leptonica.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6be82c3a3cbbd6aded7690f2d5f7f8b7b035976161d774239a0dfa3f90fb3280',
     armv7l: '6be82c3a3cbbd6aded7690f2d5f7f8b7b035976161d774239a0dfa3f90fb3280',
     x86_64: '8f1ece00717612eb72e72484be71823920c209d7b236de0b740c9a08d5aaf43b'
  })

  depends_on 'giflib' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' => :build
  depends_on 'libdeflate' => :build
  depends_on 'libjpeg_turbo' # R
  depends_on 'libpng' # R
  depends_on 'libtiff' # R
  depends_on 'libwebp' # R
  depends_on 'openjpeg' # R
  depends_on 'xzutils' => :build
  depends_on 'zlib' # R
  depends_on 'zstd' => :build

  def self.patch
    # See https://github.com/DanBloomberg/leptonica/issues/693
    system "sed -i 's,lib/cmake/leptonica,#{ARCH_LIB}/cmake/leptonica,g' CMakeLists.txt"
    system "sed -i 's,lib/pkgconfig,#{ARCH_LIB}/pkgconfig,g' CMakeLists.txt"
    system "sed -i 's,prefix}/lib,prefix}/#{ARCH_LIB},g' lept.pc.cmake"
    system "sed -i 's,set(lib,set(#{ARCH_LIB},g' src/CMakeLists.txt"
    system "sed -i 's,DESTINATION lib ARCHIVE DESTINATION lib,DESTINATION #{ARCH_LIB} ARCHIVE DESTINATION #{ARCH_LIB},g' src/CMakeLists.txt"
  end

  def self.build
    system "cmake -B builddir #{CREW_CMAKE_OPTIONS} \
        -DBUILD_SHARED_LIBS=ON \
        -Wno-dev \
        -G Ninja"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
