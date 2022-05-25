require 'package'

class Pixman < Package
  description 'Pixman is a low-level software library for pixel manipulation, providing features such as image compositing and trapezoid rasterization.'
  homepage 'http://www.pixman.org/'
  version '0.42.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/pixman/pixman.git'
  git_hashtag "pixman-#{version}"
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pixman/0.42.2_armv7l/pixman-0.42.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pixman/0.42.2_armv7l/pixman-0.42.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pixman/0.42.2_i686/pixman-0.42.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pixman/0.42.2_x86_64/pixman-0.42.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'cc34d57fb02e6ac863a726b3a13c4d80b3ba975bde965b03113da95b5f72ef6a',
     armv7l: 'cc34d57fb02e6ac863a726b3a13c4d80b3ba975bde965b03113da95b5f72ef6a',
       i686: 'e0c56f9cc30ead6a1b9b9ab7bea836d1127aec0057a09b83eae7063d11a44f18',
     x86_64: 'fa18fdd7bd6c4f8bed2199391b36b6403bee73da220b5730371e13d2f074fed8'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    --default-library=both \
    -Dgtk=disabled \
    -Dlibpng=disabled \
    -Dtests=disabled \
    builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
