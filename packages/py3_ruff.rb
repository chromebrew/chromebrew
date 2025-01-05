require 'buildsystems/python'

class Py3_ruff < Python
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.8.6-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/astral-sh/ruff.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '937b71f97daaf37df4cdbc0d43ebdba86911fb42ee7b884534eb760786b1ccbe',
     armv7l: '937b71f97daaf37df4cdbc0d43ebdba86911fb42ee7b884534eb760786b1ccbe',
       i686: '5f2f1eae47959d263c87c7812521b5c6d2a13312d5e5cf4cc70c801c90ad29f5',
     x86_64: '843404fcfa57712519fde2788acace4e70b376cad2345553baef562db98f9a6e'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build
end
