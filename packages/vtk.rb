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
    aarch64: '0e4872ed298086e3044b3e7318a9e12935dc458c3a9e87f538ef49639b828d66',
     armv7l: '0e4872ed298086e3044b3e7318a9e12935dc458c3a9e87f538ef49639b828d66',
     x86_64: '0ee81a09c1fc3b727211b6bc4d6f82ddc87571164e5be3cd28092c7086b6b8c6'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'libx11' => :build
end
