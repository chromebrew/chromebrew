require 'buildsystems/cmake'

class Vtk < CMake
  description 'VTK is an open-source software system for image processing, 3D graphics, volume rendering and visualization.'
  homepage 'https://vtk.org/'
  version '9.7.1'
  license 'BSD-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.kitware.com/vtk/vtk.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1d73d19cae383ae938523ad97da6fc9eefbd2e6e9fac2487254903c246c5aa80',
     armv7l: '1d73d19cae383ae938523ad97da6fc9eefbd2e6e9fac2487254903c246c5aa80',
     x86_64: '7e1dc9e2fc861e674fc0c399c8dc47cf0e2a090442936479054ed09f28de92ca'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libx11' => :build
end
