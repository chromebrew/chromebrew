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
    aarch64: 'da4a6fed94e4960429a68717fca27122b0d7185acde1555f6073b6de9e284359',
     armv7l: 'da4a6fed94e4960429a68717fca27122b0d7185acde1555f6073b6de9e284359',
       i686: '5f2f1eae47959d263c87c7812521b5c6d2a13312d5e5cf4cc70c801c90ad29f5',
     x86_64: '843404fcfa57712519fde2788acace4e70b376cad2345553baef562db98f9a6e'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build
end
