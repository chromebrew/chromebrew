require 'buildsystems/python'

class Py3_ruff < Python
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.11.1-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/astral-sh/ruff.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0e59655245df5711179925f4fb7e0270f73362c68a46540804aa7861de3443c5',
     armv7l: '0e59655245df5711179925f4fb7e0270f73362c68a46540804aa7861de3443c5',
       i686: 'ce8225d6e8d729cf72364517dd79b898641008c7eefa628839dbf2214a937236',
     x86_64: '92e2e4391f3448f949061cbc69b937b8fdd953fcd5646ec77de784cd7d0417e7'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build
end
