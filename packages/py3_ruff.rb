require 'buildsystems/python'

class Py3_ruff < Python
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.9.5-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/astral-sh/ruff.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dd591a11470d50533771681a2827ee8b95392cec4baa5505294188f10516024f',
     armv7l: 'dd591a11470d50533771681a2827ee8b95392cec4baa5505294188f10516024f',
       i686: '178d09031e60c6daccebc3797af76751f0cea0cfc19c7c877e0811ebdf0d6840',
     x86_64: 'c80099bd4846a136e06bc663d4774b5edd92e26308a079364b936fde810a965a'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build
end
