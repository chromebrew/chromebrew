require 'buildsystems/autotools'

class Lha < Autotools
  description 'LHa for UNIX is a console-based utility that uncompresses and compresses .lha packages.'
  homepage 'https://lha.osdn.jp/'
  version '86094cb'
  license 'lha'
  compatibility 'all'
  source_url 'https://github.com/jca02266/lha.git'
  git_hashtag '86094cb56aba34de45668f39f74fcfb61e9d7fb6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '592b6de73748121453911646eb1aac2d4c021bcd6682e0fb3a3785c99686c2aa',
     armv7l: '592b6de73748121453911646eb1aac2d4c021bcd6682e0fb3a3785c99686c2aa',
       i686: '6cb49a5a83b052f122f776f4d0f0b592a1c429bf92b039c9e660ec63abac426b',
     x86_64: '630894efdce3b4fa3f7e7e0072dcc975204834790c70e617d79e1e3d597978d0'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
end
