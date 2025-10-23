require 'buildsystems/cmake'

class Doxygen < CMake
  description 'Doxygen is the de facto standard tool for generating documentation from annotated C++ sources, but it also supports other popular programming languages such as C, Objective-C, C#, PHP, Java, Python, IDL (Corba, Microsoft, and UNO/OpenOffice flavors), Fortran, VHDL, Tcl, and to some extent D.'
  homepage 'https://www.doxygen.nl/'
  version '1.15.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/doxygen/doxygen.git'
  git_hashtag "Release_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4d665e13a9a0e5085d7e485f4c72f611b7909f5e2f34f68e44e761213955e806',
     armv7l: '4d665e13a9a0e5085d7e485f4c72f611b7909f5e2f34f68e44e761213955e806',
       i686: '3595f66e251ba2c183d0cd440faca980779a253e83fd9c214908ed36fe786a68',
     x86_64: '316fc5f28694d6c04fcfa9c69621a0fc79ab7f4a9597535a8ab3b13f6b721cd7'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3' => :build
end
