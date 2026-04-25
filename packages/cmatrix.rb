require 'buildsystems/cmake'

class Cmatrix < CMake
  description "CMatrix is a program to see the cool scrolling lines from 'The Matrix' movie."
  homepage 'https://www.asty.org/cmatrix/'
  version '2.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/abishekvashok/cmatrix.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fb874a1b94b55d11ed55c2ca0888985665cd3be72ef117990e880757a8ca47ba',
     armv7l: 'fb874a1b94b55d11ed55c2ca0888985665cd3be72ef117990e880757a8ca47ba',
       i686: '51989536aee6a1880ed03c265c15f184ceedcddeaf449388dddd0eb68ea33b40',
     x86_64: '156d620422b9c6e225d7b66b9dcaa002e760e1a9e0a7e4a70628e32a3856db37'
  })

  depends_on 'glibc' => :executable
  depends_on 'kbd' => :executable
  depends_on 'ncurses' => :executable

  cmake_options "-DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
    -DCMAKE_C_FLAGS='-I#{CREW_PREFIX}/include/ncursesw'"

  cmake_install_extras do
    FileUtils.install 'cmatrix.1', "#{CREW_DEST_MAN_PREFIX}/man1/cmatrix.1", mode: 0o644
  end
end
