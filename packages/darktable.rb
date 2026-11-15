require 'buildsystems/cmake'

class Darktable < CMake
  description 'darktable is an open source photography workflow application and raw developer.'
  homepage 'https://www.darktable.org/'
  version '5.6.1'
  license 'GPL-3'
  compatibility 'x86_64'
  source_url 'https://github.com/darktable-org/darktable.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    x86_64: '5f1993b2c86aa8e2abf27be832411e123749dd4d48249b63c2951c4703b15cf9'
  })

  depends_on 'at_spi2_core' => :library
  depends_on 'cairo' => :library
  depends_on 'colord' => :executable
  depends_on 'cups' => :library
  depends_on 'curl' => :library
  depends_on 'dbus_glib' => :library
  depends_on 'fop' => :executable
  depends_on 'gcc_lib' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'gexiv2' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gmic' => :library
  depends_on 'gphoto' => :library
  depends_on 'graphicsmagick' => :library
  depends_on 'gtk3' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'icu4c' => :library
  depends_on 'json_glib' => :library
  depends_on 'lcms' => :library
  depends_on 'lensfun' => :library
  depends_on 'libexiv2' => :library
  depends_on 'libgphoto' => :library
  depends_on 'libheif' => :library
  depends_on 'libice' => :executable
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libjxl' => :library
  depends_on 'libpng' => :library
  depends_on 'librsvg' => :library
  depends_on 'libsecret' => :library
  depends_on 'libsm' => :executable
  depends_on 'libsoup' => :library
  depends_on 'libtiff' => :library
  depends_on 'libwebp' => :library
  depends_on 'libx11' => :executable
  depends_on 'libxext' => :executable
  depends_on 'libxml2' => :library
  depends_on 'libxrandr' => :executable
  depends_on 'libxslt' => :library
  depends_on 'openexr' => :library
  depends_on 'openjpeg' => :library
  depends_on 'pango' => :library
  depends_on 'potrace' => :library
  depends_on 'pugixml' => :library
  depends_on 'sdl2' => :library
  depends_on 'sdl2_compat' => :library
  depends_on 'sommelier' => :logical
  depends_on 'sqlite' => :library
  depends_on 'zlib' => :library

  cmake_options '-DDONT_USE_INTERNAL_LUA=Off'
end
