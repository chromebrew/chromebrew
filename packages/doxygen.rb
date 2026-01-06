require 'buildsystems/cmake'

class Doxygen < CMake
  description 'Doxygen is the de facto standard tool for generating documentation from annotated C++ sources, but it also supports other popular programming languages such as C, Objective-C, C#, PHP, Java, Python, IDL (Corba, Microsoft, and UNO/OpenOffice flavors), Fortran, VHDL, Tcl, and to some extent D.'
  homepage 'https://www.doxygen.nl/'
  version '1.16.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/doxygen/doxygen.git'
  git_hashtag "Release_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c06666fe7999c337dbf9e28f4a280f1d97771120643a56a22b3a3163babe3d98',
     armv7l: 'c06666fe7999c337dbf9e28f4a280f1d97771120643a56a22b3a3163babe3d98',
       i686: 'fde921f416e292fc8921db845834df962e98b739881e1e27f9aa65b6576b1cd2',
     x86_64: '62663412b949a409afcd419d8b662e31a5dca9d5be7aed73591bce7051cff31a'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3' => :build
end
