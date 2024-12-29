require 'buildsystems/cmake'

class Doxygen < CMake
  description 'Doxygen is the de facto standard tool for generating documentation from annotated C++ sources, but it also supports other popular programming languages such as C, Objective-C, C#, PHP, Java, Python, IDL (Corba, Microsoft, and UNO/OpenOffice flavors), Fortran, VHDL, Tcl, and to some extent D.'
  homepage 'https://www.doxygen.nl/'
  version '1.13.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/doxygen/doxygen.git'
  git_hashtag 'Release_1_11_0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '532b57c91866ffa061c7b1f4d2086d5283701cf0262f1dc6a1c4842eca71fa46',
     armv7l: '532b57c91866ffa061c7b1f4d2086d5283701cf0262f1dc6a1c4842eca71fa46',
       i686: '44a7cd6b1f99c8327fce2c05b4eb3c338d855630e1c57aa85350d28a0a5e54a3',
     x86_64: 'af37b6c800d705e67aea6ee5eb1e6eb87df2c908604a29698ac58d1f94191202'
  })

  depends_on 'python3' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
