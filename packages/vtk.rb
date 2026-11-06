require 'buildsystems/cmake'

class Vtk < CMake
  description 'VTK is an open-source software system for image processing, 3D graphics, volume rendering and visualization.'
  homepage 'https://vtk.org/'
  version '9.7.2'
  license 'BSD-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.kitware.com/vtk/vtk.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f30084d362f3145fe2f29346d781af3fb72568b58d46b30c35e79470f8184d1d',
     armv7l: 'f30084d362f3145fe2f29346d781af3fb72568b58d46b30c35e79470f8184d1d',
     x86_64: '02e173d576472dafba052621cf184602f89343d122d1cdd0c9cb12b47f7d99f8'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libx11' => :build
end
