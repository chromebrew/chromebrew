require 'package'

class Libgdiplus < Package
  description 'The mono library that provides a GDI+-compatible API on non-windows operating systems.'
  homepage 'https://www.mono-project.com/docs/gui/libgdiplus/'
  version '6.1'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/mono/libgdiplus.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '23101c669d315dc3bfd3b7cbc95791ff47920a906a77f4f7004d0402175cc12a',
     armv7l: '23101c669d315dc3bfd3b7cbc95791ff47920a906a77f4f7004d0402175cc12a',
     x86_64: '944f8319acc34f45ad2aa718a343cc4b9481784424fa7e529eec930d663167c4'
  })

  depends_on 'cairo'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'giflib'
  depends_on 'glib'
  depends_on 'glibc' # R
  depends_on 'graphite'
  depends_on 'imake' => :build
  depends_on 'libexif'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'libwebp'
  depends_on 'expat' # R
  depends_on 'harfbuzz' # R
  depends_on 'libdeflate' # R
  depends_on 'pango' # R
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS} \
      --with-libexif \
      --with-libtiff \
      --with-jpeg \
      --with-libgif \
      --with-x11"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
