require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.8.1-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6639637ad8b6b282454346732d7e0a741c220493b72e2c670d15900e31c2a048',
     armv7l: '6639637ad8b6b282454346732d7e0a741c220493b72e2c670d15900e31c2a048',
       i686: 'c069bec3751bdc9169b66ed03a625f3fa54342ebbf8afd325e92e973ab30ad34',
     x86_64: '79ce9b846170d091381164ca4eadef1ced8ffaf2659315a396ecb23ce532da6f'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'rust' => :build

  no_source_build
end
