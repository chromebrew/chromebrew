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
     x86_64: '150aa6f977c9cfd4234b4fa3123f3984dac26b4e9b064a9956a5105911caa310'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'rust' => :build

  no_source_build
end
