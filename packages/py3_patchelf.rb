require 'buildsystems/pip'

class Py3_patchelf < Pip
  description 'Patchelf is a small utility to modify the dynamic linker and RPATH of ELF executables.'
  homepage 'https://pypi.org/project/patchelf'
  version "0.17.2.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9f32ff61c5884938b7d1075f1aebf308d875d5b190a9361e6a32d7450efa4911',
     armv7l: '9f32ff61c5884938b7d1075f1aebf308d875d5b190a9361e6a32d7450efa4911',
       i686: 'bbdffaa5e548b7398a1765149d4e3f3ea3839d1800e1951b9e1b10099fc17e33',
     x86_64: '83297a44daff020adaa8a375ea199de73fbd697a7a15af84d6df3b3582de7ac0'
  })

  depends_on 'python3'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  conflicts_ok # Conflicts with patchelf.
  no_source_build
end
