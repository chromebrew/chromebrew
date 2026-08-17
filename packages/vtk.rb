require 'buildsystems/cmake'

class Vtk < CMake
  description 'VTK is an open-source software system for image processing, 3D graphics, volume rendering and visualization.'
  homepage 'https://vtk.org/'
  version '9.7.0'
  license 'BSD-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.kitware.com/vtk/vtk.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '939862b7249fd16fda79cce98e35a6d7d5cbcdd960a04b327e9c38e4e294e27f',
     armv7l: '939862b7249fd16fda79cce98e35a6d7d5cbcdd960a04b327e9c38e4e294e27f',
     x86_64: '7451e45c852f648586a636be1a9bcd4803b6b02e0de9f0f7cbd9a324de9cdaaf'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libx11' => :build
end
