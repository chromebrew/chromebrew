require 'buildsystems/pip'

class Py3_patchelf < Pip
  description 'Patchelf is a small utility to modify the dynamic linker and RPATH of ELF executables.'
  homepage 'https://pypi.org/project/patchelf'
  version "0.17.2.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '751a985d0d90201e622d74a994d67bb6ab99cbad69ec10fbf86835a365ae9b08',
     armv7l: '751a985d0d90201e622d74a994d67bb6ab99cbad69ec10fbf86835a365ae9b08',
       i686: '086ac21c8a27b63546e0f3357df84612987fcb01e3d3371bb052f232396ffd19',
     x86_64: 'c4ca517d99eb7f472e6c040b51b20b0896e5e8a3c8ae5f39a90ac9da5dc174b5'
  })

  depends_on 'python3'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  conflicts_ok # Conflicts with patchelf.
  no_source_build
end
