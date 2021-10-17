require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  @_ver = '3.21.3'
  version @_ver
  license 'CMake'
  compatibility 'all'
  source_url 'https://github.com/Kitware/CMake.git'
  git_hashtag 'v' + @_ver

  depends_on 'expat'
  depends_on 'jsoncpp'
  depends_on 'zlibpkg'
  depends_on 'bz2'
  depends_on 'xzutils'
  depends_on 'libnghttp2'
  depends_on 'zstd'
  depends_on 'libarchive'
  depends_on 'librhash'
  depends_on 'libuv'
  depends_on 'llvm' => :build

  def self.patch
    if Dir.exist? "#{CREW_PREFIX}/include/ncursesw"
      system "sed -i \"51s,$,\\n  set(CURSES_INCLUDE_PATH #{CREW_PREFIX}/include/ncursesw),\" Modules/FindCurses.cmake"
    end
  end

  def self.build
    system "#{CREW_ENV_OPTIONS} ./bootstrap \
              --prefix=#{CREW_PREFIX} \
              --docdir=#{CREW_PREFIX}/share/doc \
              --mandir=#{CREW_MAN_PREFIX} \
              --system-curl \
              --system-expat \
              --system-jsoncpp \
              --system-zlib \
              --system-bzip2 \
              --system-liblzma \
              --system-nghttp2 \
              --system-zstd \
              --system-libarchive \
              --system-librhash \
              --system-libuv \
              --bootstrap-system-libuv \
              --bootstrap-system-jsoncpp \
              --bootstrap-system-librhash \
              --no-qt-gui"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
