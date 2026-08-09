require 'buildsystems/pip'

class Py3_patchelf < Pip
  description 'Patchelf is a small utility to modify the dynamic linker and RPATH of ELF executables.'
  homepage 'https://pypi.org/project/patchelf'
  version "0.19.1.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fcfef738b7d77b66b251d900f180b70a608504d32f295a4a4a341799ec6137f7',
     armv7l: 'fcfef738b7d77b66b251d900f180b70a608504d32f295a4a4a341799ec6137f7',
       i686: '1e92c6807e1075dc3e0a9e4018ed0b581c3b5a55d8e386935f26bccbb89847c2',
     x86_64: '1b84db6663f4ef56cc92eb69b65dbdb261aa03630d8590b4a369dd99636799f9'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'python3'
  depends_on 'python3' => :logical

  conflicts_ok # Conflicts with patchelf.
  no_source_build
end
