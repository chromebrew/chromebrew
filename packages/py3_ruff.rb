require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version '0.6.5-py3.12'
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '92186c7bb3f0e78baaae5c7753d42577cc344746aff14f311aa0f25a019905bc',
     armv7l: '92186c7bb3f0e78baaae5c7753d42577cc344746aff14f311aa0f25a019905bc',
       i686: 'd23df537cfba9e85cbe7f591db7d23b045513abd216cf1def7a06a5fdf9ec9e7',
     x86_64: '9628abfaa0cba43624ac8c2ff0b2f2090e7410e76e3ea6ae1c36a7c74f12c5b4'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'rust' => :build

  no_source_build
end
