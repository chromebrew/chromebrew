require 'buildsystems/cmake'

class Doxygen < CMake
  description 'Doxygen is the de facto standard tool for generating documentation from annotated C++ sources, but it also supports other popular programming languages such as C, Objective-C, C#, PHP, Java, Python, IDL (Corba, Microsoft, and UNO/OpenOffice flavors), Fortran, VHDL, Tcl, and to some extent D.'
  homepage 'http://www.doxygen.nl/'
  version '1.11.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/doxygen/doxygen.git'
  git_hashtag 'Release_1_11_0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '15dedc67203dc4b24273e0efed9296c7cdd63e6a3c65e869047890c9bc24aab3',
     armv7l: '15dedc67203dc4b24273e0efed9296c7cdd63e6a3c65e869047890c9bc24aab3',
       i686: 'aad9ef98fd93177a5d90c4d616de28c49a58a4cf586a4a79ca927836dc02bfb3',
     x86_64: 'f3bdbafbb4e0f1e912959fbba038b403180952a17e48704283d072225b14e806'
  })

  depends_on 'python3' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
