require 'buildsystems/cmake'

class Vtk < CMake
  description 'VTK is an open-source software system for image processing, 3D graphics, volume rendering and visualization.'
  homepage 'https://vtk.org/'
  version '9.6.1'
  license 'BSD-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.kitware.com/vtk/vtk.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e0df4cf3d27adf7dcf0a9d36ceac2da27f81dfb451672ce68698b7b7b9324823',
     armv7l: 'e0df4cf3d27adf7dcf0a9d36ceac2da27f81dfb451672ce68698b7b7b9324823',
     x86_64: '03c2031d80010fc06e9383c3d306727fe904753c3695b30f1f8c727540fe5495'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'libx11' => :build
end
