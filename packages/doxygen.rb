require 'buildsystems/cmake'

class Doxygen < CMake
  description 'Doxygen is the de facto standard tool for generating documentation from annotated C++ sources, but it also supports other popular programming languages such as C, Objective-C, C#, PHP, Java, Python, IDL (Corba, Microsoft, and UNO/OpenOffice flavors), Fortran, VHDL, Tcl, and to some extent D.'
  homepage 'https://www.doxygen.nl/'
  version '1.16.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/doxygen/doxygen.git'
  git_hashtag "Release_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6ebb91dfdada72fd67a74448e5b94f3ecaf64c356beeb51672836da2feb2b21d',
     armv7l: '6ebb91dfdada72fd67a74448e5b94f3ecaf64c356beeb51672836da2feb2b21d',
       i686: '7d9a32d5344317d7ab1fcd2cff69932ab6fa12377f38a243036c113e3d1547f7',
     x86_64: '73093164e80162758ec5d49051746eedd1514b6a589bd54963a592e3af760cda'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3' => :build
end
