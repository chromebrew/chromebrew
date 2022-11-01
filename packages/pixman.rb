require 'package'

class Pixman < Package
  description 'Pixman is a low-level software library for pixel manipulation, providing features such as image compositing and trapezoid rasterization.'
  homepage 'http://www.pixman.org/'
  version '0.42.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/pixman/pixman.git'
  git_hashtag "pixman-#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pixman/0.42.0_armv7l/pixman-0.42.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pixman/0.42.0_armv7l/pixman-0.42.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pixman/0.42.0_i686/pixman-0.42.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pixman/0.42.0_x86_64/pixman-0.42.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd09bd8d2b7555bb26bc2058d8bb2f08a6151565554cb3e4daa58c3bfaddadf8b',
     armv7l: 'd09bd8d2b7555bb26bc2058d8bb2f08a6151565554cb3e4daa58c3bfaddadf8b',
       i686: '32d124c01386abe44249b9517024075bc88b339dd6f029b9aae2325608972d6e',
     x86_64: '283e9c8e9960c10fb7f4271cf5460bc5bca66f245c0cae73af10ce66a1f8fca0'
  })

  depends_on 'gcc' # R
  depends_on 'glibc' # R

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    --default-library=both \
    -Dgtk=disabled \
    -Dlibpng=disabled \
    -Dtests=disabled \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
