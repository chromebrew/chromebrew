require 'buildsystems/cmake'

class Doxygen < CMake
  description 'Doxygen is the de facto standard tool for generating documentation from annotated C++ sources, but it also supports other popular programming languages such as C, Objective-C, C#, PHP, Java, Python, IDL (Corba, Microsoft, and UNO/OpenOffice flavors), Fortran, VHDL, Tcl, and to some extent D.'
  homepage 'https://www.doxygen.nl/'
  version '1.18.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/doxygen/doxygen.git'
  git_hashtag "Release_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'edbb15026408011e005e2a4b6b8eb01847c53de45967d067b21a4efccb578fd6',
     armv7l: 'edbb15026408011e005e2a4b6b8eb01847c53de45967d067b21a4efccb578fd6',
       i686: '3d30da5947bb208241a08f2e2815016a917b6bb93595bc93475ebdf8b06cd761',
     x86_64: '607a444286eb9ff6772b1ff4f02368f05df07b6acbd48c7329fe64981e76f2ca'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'python3' => :build
end
