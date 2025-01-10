require 'buildsystems/cmake'

class Doxygen < CMake
  description 'Doxygen is the de facto standard tool for generating documentation from annotated C++ sources, but it also supports other popular programming languages such as C, Objective-C, C#, PHP, Java, Python, IDL (Corba, Microsoft, and UNO/OpenOffice flavors), Fortran, VHDL, Tcl, and to some extent D.'
  homepage 'https://www.doxygen.nl/'
  version '1.13.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/doxygen/doxygen.git'
  git_hashtag "Release_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0af737ada31ad5ec8bdf9626ab99bbced14ac6f57f7443f45d76130aac7d3671',
     armv7l: '0af737ada31ad5ec8bdf9626ab99bbced14ac6f57f7443f45d76130aac7d3671',
       i686: 'd0d056a617ba2a7bbc3b75de42a75f288da5f24419a3199b13840ccc1128d36c',
     x86_64: 'f5047b1651a0a7bd84ab4342d0e390f694e80a90bf43f9c11b35d5b38750d85c'
  })

  depends_on 'python3' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
