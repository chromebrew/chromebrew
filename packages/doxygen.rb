require 'buildsystems/cmake'

class Doxygen < CMake
  description 'Doxygen is the de facto standard tool for generating documentation from annotated C++ sources, but it also supports other popular programming languages such as C, Objective-C, C#, PHP, Java, Python, IDL (Corba, Microsoft, and UNO/OpenOffice flavors), Fortran, VHDL, Tcl, and to some extent D.'
  homepage 'http://www.doxygen.nl/'
  version '1.9.8'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/doxygen/doxygen.git'
  git_hashtag 'Release_1_9_8'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/doxygen/1.9.8_armv7l/doxygen-1.9.8-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/doxygen/1.9.8_armv7l/doxygen-1.9.8-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/doxygen/1.9.8_i686/doxygen-1.9.8-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/doxygen/1.9.8_x86_64/doxygen-1.9.8-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6cf8a2cb388ccc24c5068d5828e79f9334e8b774bd0085656f6dced40978063f',
     armv7l: '6cf8a2cb388ccc24c5068d5828e79f9334e8b774bd0085656f6dced40978063f',
       i686: '972aa02dcd763eab9c7711830f2f05bbab98d7ad0468bff59ded6cb90e31d244',
     x86_64: '718c24a7a13b9d7c9fe519d60e66e9a23e6b4401b09ce615e54ca9d8792e5fec'
  })

  depends_on 'python3' => :build
end
