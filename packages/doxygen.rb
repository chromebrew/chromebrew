require 'buildsystems/cmake'

class Doxygen < CMake
  description 'Doxygen is the de facto standard tool for generating documentation from annotated C++ sources, but it also supports other popular programming languages such as C, Objective-C, C#, PHP, Java, Python, IDL (Corba, Microsoft, and UNO/OpenOffice flavors), Fortran, VHDL, Tcl, and to some extent D.'
  homepage 'https://www.doxygen.nl/'
  version '1.13.2'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/doxygen/doxygen.git'
  git_hashtag "Release_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f312c4c453177ff564ad789c20ab1f759a5ca4a73c2cd00fa02ccdbaa2534e46',
     armv7l: 'f312c4c453177ff564ad789c20ab1f759a5ca4a73c2cd00fa02ccdbaa2534e46',
       i686: 'a326ae94a2750aab1051ce0248c76aeb36a9a1358f8cf964c25ca23519d8dca9',
     x86_64: '11fd469f24e49b78d8bbb2a84cc00875679c39bbec68072ca4506002dc723f7d'
  })

  depends_on 'python3' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
