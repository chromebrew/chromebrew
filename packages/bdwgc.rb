require 'buildsystems/cmake'

class Bdwgc < CMake
  description 'The Boehm-Demers-Weiser conservative C/C++ Garbage Collector'
  homepage 'https://www.hboehm.info/gc/'
  version '8.2.4'
  license 'custom'
  compatibility 'all'
  source_url 'https://github.com/ivmai/bdwgc/releases/download/v8.2.4/gc-8.2.4.tar.gz'
  source_sha256 '3d0d3cdbe077403d3106bb40f0cbb563413d6efdbb2a7e1cd6886595dec48fc2'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bdwgc/8.2.4_armv7l/bdwgc-8.2.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bdwgc/8.2.4_armv7l/bdwgc-8.2.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bdwgc/8.2.4_i686/bdwgc-8.2.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bdwgc/8.2.4_x86_64/bdwgc-8.2.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'afb82388b553021575812b5e8c788c8530f44193688123e5ff5a012122287f26',
     armv7l: 'afb82388b553021575812b5e8c788c8530f44193688123e5ff5a012122287f26',
       i686: 'e5187ea6bdfb5b478309039aa35e422c7a558cf0928f08af778f2a3f1362487f',
     x86_64: '66a43028848541f4352b18c711d675abaa897a940fa5c2cd434b40cc5fb5851d'
  })

  depends_on 'glibc' # R
end
