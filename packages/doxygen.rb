require 'buildsystems/cmake'

class Doxygen < CMake
  description 'Doxygen is the de facto standard tool for generating documentation from annotated C++ sources, but it also supports other popular programming languages such as C, Objective-C, C#, PHP, Java, Python, IDL (Corba, Microsoft, and UNO/OpenOffice flavors), Fortran, VHDL, Tcl, and to some extent D.'
  homepage 'http://www.doxygen.nl/'
  version '1.9.8'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/doxygen/doxygen.git'
  git_hashtag 'Release_1_9_8'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/doxygen/1.9.8_armv7l/doxygen-1.9.8-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/doxygen/1.9.8_armv7l/doxygen-1.9.8-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/doxygen/1.9.8_i686/doxygen-1.9.8-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/doxygen/1.9.8_x86_64/doxygen-1.9.8-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd9b875d58bdaf11ad6cdb863987ae930f0f2014e926a3e47aa699405e42795da',
     armv7l: 'd9b875d58bdaf11ad6cdb863987ae930f0f2014e926a3e47aa699405e42795da',
       i686: '67043de7132eba2845ff9ffb77f27d3c64b9b1bddce916a7805167509e90a9f0',
     x86_64: '55f9be90af5bf1204333b40308d15163f579374e7de5e0b672b33a43b568c305'
  })

  depends_on 'python3' => :build
end
