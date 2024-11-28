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
    aarch64: '9944fcbfdf2958d42bbc16ecbb51a903bb90689fca03db4e4829af738b41f3f6',
     armv7l: '9944fcbfdf2958d42bbc16ecbb51a903bb90689fca03db4e4829af738b41f3f6',
       i686: '7401356e78abb52b4d43f261d088faf8c3078bfd18aba5229067b5dda037c227',
     x86_64: 'b9a4d81999c3e7a2928f47e244ed6c79128052d85ad5fca45e3279ab68e0643e'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'rust' => :build

  no_source_build
end
