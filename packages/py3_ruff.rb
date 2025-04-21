require 'buildsystems/python'

class Py3_ruff < Python
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.11.6-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/astral-sh/ruff.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6c21d565bef2884d01e10ea499ed442c88a74986abc88dbac8d006702fea99df',
     armv7l: '6c21d565bef2884d01e10ea499ed442c88a74986abc88dbac8d006702fea99df',
       i686: '8a57a82a53d844105c512bc5130b48b9f4ef266a1cab91f6bebc9694648d8fff',
     x86_64: 'd68c4186c57b0fad81e9737d0ddab39ce7401edc9c83396523e078169774d7ae'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build
end
