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
    aarch64: '68f2aa9fed058defc501ef90e24556d1b3d9e45810fcffc355da0dbd14031ccf',
     armv7l: '68f2aa9fed058defc501ef90e24556d1b3d9e45810fcffc355da0dbd14031ccf',
       i686: '0f3ff1eed758a57af851b33b7950793be7336584314e48b0e29983ac9cc6610d',
     x86_64: 'eb9addc779227c7ef2fdfaa394944edc18116ec1425fe7b4fd3229649a074112'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3' => :build
end
