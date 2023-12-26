require 'buildsystems/cmake'

class Doxygen < CMake
  description 'Doxygen is the de facto standard tool for generating documentation from annotated C++ sources, but it also supports other popular programming languages such as C, Objective-C, C#, PHP, Java, Python, IDL (Corba, Microsoft, and UNO/OpenOffice flavors), Fortran, VHDL, Tcl, and to some extent D.'
  homepage 'http://www.doxygen.nl/'
  version '1.10.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/doxygen/doxygen.git'
  git_hashtag 'Release_1_10_0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/doxygen/1.10.0_armv7l/doxygen-1.10.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/doxygen/1.10.0_armv7l/doxygen-1.10.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/doxygen/1.10.0_i686/doxygen-1.10.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/doxygen/1.10.0_x86_64/doxygen-1.10.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd5a9ea1719e0a44532bae613e98afd3d2b6430318ab06b4706a5e33d2170d762',
     armv7l: 'd5a9ea1719e0a44532bae613e98afd3d2b6430318ab06b4706a5e33d2170d762',
       i686: '1af76638f965691d5299a812c532c3e93b21c0b01587f8394e93a024bd811325',
     x86_64: 'ae4d3d8366a191999b40d823eee857f9edb8b38a2bdf8ce89b2de092607ff7eb'
  })

  depends_on 'python3' => :build
end
