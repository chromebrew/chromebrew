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
       i686: '0a579cc5131dc04ce5c48e9dda0605c1975772281581319c51c13e63a82af3e4',
     x86_64: '150aa6f977c9cfd4234b4fa3123f3984dac26b4e9b064a9956a5105911caa310'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'rust' => :build

  no_source_build
end
