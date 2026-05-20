require 'buildsystems/cmake'

class Vtk < CMake
  description 'VTK is an open-source software system for image processing, 3D graphics, volume rendering and visualization.'
  homepage 'https://vtk.org/'
  version '9.6.2'
  license 'BSD-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.kitware.com/vtk/vtk.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6df16cb7af4e50909b500edd35944b7a5cb697c67ef21c56fbf93ad994552ac9',
     armv7l: '6df16cb7af4e50909b500edd35944b7a5cb697c67ef21c56fbf93ad994552ac9',
     x86_64: 'a66010a1c60d3c8457911365bb96ae606a3f45f0233a6782a26e2095595d95c8'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libx11' => :build
end
