require 'buildsystems/pip'

class Py3_patchelf < Pip
  description 'Patchelf is a small utility to modify the dynamic linker and RPATH of ELF executables.'
  homepage 'https://pypi.org/project/patchelf'
  version "0.17.2.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '39d63030985c4762e7af75295d79e39c82e875492397795dbc563038a1460604',
     armv7l: '39d63030985c4762e7af75295d79e39c82e875492397795dbc563038a1460604',
       i686: 'd8a51bd40084710a4e529ef0bf2e32356d9126e3e5e94121ce28d1f57d0d9731',
     x86_64: '4dd3fea26a5d41aabd52ee7378df159050b5f34e3afeba58b9fd86786d044420'
  })

  depends_on 'python3'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  conflicts_ok # Conflicts with patchelf.
  no_source_build
end
