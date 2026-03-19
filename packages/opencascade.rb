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
    aarch64: 'fa202a270d5e48eeca459ba1ddc0d476fa9899cab2759b2a07f318e856879587',
     armv7l: 'fa202a270d5e48eeca459ba1ddc0d476fa9899cab2759b2a07f318e856879587',
     x86_64: 'f6d976403c53f414bcf886d16c1034761ccd79d6b94e21fa2432198e1768e281'
  })

  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libglvnd' # R
  depends_on 'libx11' # R
  depends_on 'tcl' # R

  cmake_options "-DUSE_TK=OFF -D3RDPARTY_TCL_INCLUDE_DIR=/usr/local/include/tcl#{Tcl.version.rpartition('.')[0]}"
end
