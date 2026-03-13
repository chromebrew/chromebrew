require 'buildsystems/cmake'
require_relative 'tcl'

class Opencascade < CMake
  description 'Open CASCADE Technology (OCCT) is an open-source software development platform for 3D CAD, CAM, CAE.'
  homepage 'https://occt3d.com/'
  version '7.9.3'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/Open-Cascade-SAS/OCCT.git'
  git_hashtag "V#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     x86_64: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  })

  depends_on 'freetype'
  depends_on 'tcl'

  cmake_options "-DUSE_TK=OFF -D3RDPARTY_TCL_INCLUDE_DIR=/usr/local/include/tcl#{Tcl.version.rpartition('.')[0]}"
end
