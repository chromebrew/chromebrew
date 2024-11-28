require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.8.0-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '838c0e680136266463abc14b26c86acc0cccd76f0c036d7cb9e9a24771718f82',
     armv7l: '838c0e680136266463abc14b26c86acc0cccd76f0c036d7cb9e9a24771718f82',
       i686: 'c069bec3751bdc9169b66ed03a625f3fa54342ebbf8afd325e92e973ab30ad34',
     x86_64: '7243f7a5352b1f4239097266f496acb309078372edb3d7d17138b0eb52df242a'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'rust' => :build

  no_source_build
end
