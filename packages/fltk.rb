require 'buildsystems/cmake'

class Fltk < CMake
  description 'Fast Light Toolkit or FLTK (pronounced "fulltick") is a cross-platform C++ GUI toolkit'
  homepage 'https://www.fltk.org/'
  version '1.4.5'
  license 'FLTK and LGPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://github.com/fltk/fltk/releases/download/release-#{version}/fltk-#{version}-source.tar.bz2"
  source_sha256 'b5a52489b7ffae196db2076adb4c1b18170db0d047f5e93539a382603461564b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dba8dab43b88e317c70b674d84cf787ed56f5e7ff81e66b51056be549a85bcec',
     armv7l: 'dba8dab43b88e317c70b674d84cf787ed56f5e7ff81e66b51056be549a85bcec',
     x86_64: '3f46ea64f96026a3b8c62f4ea8951a69365c7c2340e9d3c64885978980946159'
  })

  depends_on 'cairo' => :library
  depends_on 'dbus' => :library
  depends_on 'fontconfig' => :library
  depends_on 'freetype' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'graphviz' => :build
  depends_on 'harfbuzz' => :library
  depends_on 'libdecor' => :library
  depends_on 'libglu' => :library
  depends_on 'libglvnd' => :library
  depends_on 'libice' => :library
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libpng' => :library
  depends_on 'libsm' => :library
  depends_on 'libx11' => :library
  depends_on 'libxaw' => :library
  depends_on 'libxcursor' => :library
  depends_on 'libxext' => :library
  depends_on 'libxfixes' => :library
  depends_on 'libxft' => :library
  depends_on 'libxinerama' => :library
  depends_on 'libxkbcommon' => :library
  depends_on 'libxpm' => :library
  depends_on 'libxpresent' => :library
  depends_on 'libxrender' => :library
  depends_on 'libxres' => :library
  depends_on 'libxss' => :library
  depends_on 'libxv' => :library
  depends_on 'mesa' => :executable
  depends_on 'pango' => :library
  depends_on 'sommelier' => :logical
  depends_on 'wayland' => :library
  depends_on 'xcb_util' => :executable
  depends_on 'xcb_util_cursor' => :executable
  depends_on 'xcb_util_image' => :executable
  depends_on 'xcb_util_keysyms' => :executable
  depends_on 'xcb_util_renderutil' => :executable
  depends_on 'xcb_util_wm' => :executable
  depends_on 'xcb_util_xrm' => :executable
  depends_on 'zlib' => :library

  cmake_options '-DFLTK_BUILD_SHARED_LIBS=ON'
end
