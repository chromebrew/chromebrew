require 'buildsystems/cmake'
require_relative 'tcl'

class Opencascade < CMake
  description 'Open CASCADE Technology (OCCT) is an open-source software development platform for 3D CAD, CAM, CAE.'
  homepage 'https://occt3d.com/'
  version '8.0.1'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/Open-Cascade-SAS/OCCT.git'
  git_hashtag "V#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '34cb75313d2d8df4abf9f9398ed9bd5289aa11914657a4804bc4f73b2366ef47',
     armv7l: '34cb75313d2d8df4abf9f9398ed9bd5289aa11914657a4804bc4f73b2366ef47',
     x86_64: 'eda57e065287f630c235a5dd377faa177a4744cb9a0e8f63545e8be1e61b37ad'
  })

  depends_on 'expat' => :library
  depends_on 'fontconfig' => :library
  depends_on 'freetype' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'harfbuzz' # R
  depends_on 'libglvnd' => :library
  depends_on 'libx11' => :library
  depends_on 'tcl' => :library

  cmake_options "-DUSE_TK=OFF -D3RDPARTY_TCL_INCLUDE_DIR=/usr/local/include/tcl#{Tcl.version.rpartition('.')[0]}"
end
