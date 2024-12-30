require 'buildsystems/cmake'

class Doxygen < CMake
  description 'Doxygen is the de facto standard tool for generating documentation from annotated C++ sources, but it also supports other popular programming languages such as C, Objective-C, C#, PHP, Java, Python, IDL (Corba, Microsoft, and UNO/OpenOffice flavors), Fortran, VHDL, Tcl, and to some extent D.'
  homepage 'https://www.doxygen.nl/'
  version '1.13.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/doxygen/doxygen.git'
  git_hashtag "Release_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd80bcd882e5c3919628531f753fd6e140051685d79e8c66644c362807855c596',
     armv7l: 'd80bcd882e5c3919628531f753fd6e140051685d79e8c66644c362807855c596',
       i686: 'bdc83014941321742354a263bfa183cf26d099ca62ea11663c1273dd12e7a841',
     x86_64: '75c759b7f4df9c08b9bff7808767b7d2decdc19524b99cc92f7ed2e588660c26'
  })

  depends_on 'python3' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
