require 'buildsystems/python'

class Py3_ruff < Python
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.11.7-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/astral-sh/ruff.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '231e47242f5e4661c48f1981bfad688312291b358a697a66f4f6dffecc0fff9f',
     armv7l: '231e47242f5e4661c48f1981bfad688312291b358a697a66f4f6dffecc0fff9f',
       i686: '7cdc17561e9f33767767daf552957d134570165a83561940c7961adb6d7a3ece',
     x86_64: '619ea0dc08acdf0cbdc983970202122821b6f3713858268fff9772616dcf75fa'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build
end
