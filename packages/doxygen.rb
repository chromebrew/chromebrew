require 'buildsystems/cmake'

class Doxygen < CMake
  description 'Doxygen is the de facto standard tool for generating documentation from annotated C++ sources, but it also supports other popular programming languages such as C, Objective-C, C#, PHP, Java, Python, IDL (Corba, Microsoft, and UNO/OpenOffice flavors), Fortran, VHDL, Tcl, and to some extent D.'
  homepage 'https://www.doxygen.nl/'
  version '1.17.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/doxygen/doxygen.git'
  git_hashtag "Release_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a004918fa0499c81a5b3b26e805c2f3cc7e6c00fd96ac41f6f0e79373b6c99d9',
     armv7l: 'a004918fa0499c81a5b3b26e805c2f3cc7e6c00fd96ac41f6f0e79373b6c99d9',
       i686: 'ea2d11aaebe036539c0858eac579cca598c6469beb0f8eb6a7d22c23360649fc',
     x86_64: '1f9f02bbcb1d1e1c813786cccb5126ba0d642cbc228c479bbeea1d1afc5f992c'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'python3' => :build
end
