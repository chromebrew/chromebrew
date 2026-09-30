require 'buildsystems/meson'

class Libvips < Meson
  description 'A fast image processing library with low memory needs'
  homepage 'https://www.libvips.org/'
  version '8.18.7'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://github.com/libvips/libvips/archive/v#{version}.tar.gz"
  source_sha256 '5024b4b36f20e722c267f4a9bfbdbbafb3b37d48d7125cf425c55bbf76cc9286'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1b2028f2c0cca0849b1952e7524ebaa0aaea1f82f4e19beb5e4d750060d22510',
     armv7l: '1b2028f2c0cca0849b1952e7524ebaa0aaea1f82f4e19beb5e4d750060d22510',
     x86_64: '3aa55a2ace54809937f12d347b219bf70629d1fb6be2accb85ba2708e25a47ba'
  })

  depends_on 'cairo' => :library
  depends_on 'cfitsio' => :library
  depends_on 'expat' => :library
  depends_on 'fftw' => :library
  depends_on 'fontconfig' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gstreamer'
  depends_on 'highway' => :library
  depends_on 'imagemagick7' => :library
  depends_on 'lcms' => :library
  depends_on 'libarchive' => :library
  depends_on 'libexif' => :library
  depends_on 'libgsf'
  depends_on 'libheif' => :library
  depends_on 'libimagequant' => :library
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libjxl' => :library
  depends_on 'libpng' => :library
  depends_on 'librsvg' => :library
  depends_on 'libtiff' => :library
  depends_on 'libwebp' => :library
  depends_on 'openexr' => :library
  depends_on 'openjpeg' => :library
  depends_on 'pango' => :library
  depends_on 'poppler' => :library
  depends_on 'zlib' => :library
end
