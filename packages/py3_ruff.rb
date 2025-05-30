require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.11.12-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bd7a84a80992a109d351ced936b8cb96b68d189e97e5f4b6f8eb93927f0ecae1',
     armv7l: 'bd7a84a80992a109d351ced936b8cb96b68d189e97e5f4b6f8eb93927f0ecae1',
       i686: 'c4a7c02c031fe1c22f68eeddf57e238da86989d12cbbab0feb33622e7180a081',
     x86_64: '847ca52fcf13ef0123872559ed114951eca55329da365175108e03d758925044'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build

  no_source_build
end
