require 'buildsystems/cmake'
require_relative 'tcl'

class Opencascade < CMake
  description 'Open CASCADE Technology (OCCT) is an open-source software development platform for 3D CAD, CAM, CAE.'
  homepage 'https://occt3d.com/'
  version '8.0.0'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/Open-Cascade-SAS/OCCT.git'
  git_hashtag "V#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1f1f1911a0243a682a99b277fc2efa757737bce13cfb5c245e0d731ab9e919f9',
     armv7l: '1f1f1911a0243a682a99b277fc2efa757737bce13cfb5c245e0d731ab9e919f9',
     x86_64: 'b12c1a66aca729eca05995a813f78dd5ccdf6b03b5be3fb9d0262c3fdc899649'
  })

  depends_on 'expat' => :library
  depends_on 'fontconfig' => :library
  depends_on 'freetype' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'harfbuzz' # R
  depends_on 'libglvnd' => :library
  depends_on 'libx11' => :library
  depends_on 'tcl' => :library

  cmake_options "-DUSE_TK=OFF -D3RDPARTY_TCL_INCLUDE_DIR=/usr/local/include/tcl#{Tcl.version.rpartition('.')[0]}"
end
