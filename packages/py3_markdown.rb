require 'buildsystems/pip'

class Py3_markdown < Pip
  description 'Markdown is a Python implementation of Markdown.'
  homepage 'https://python-markdown.github.io/'
  version "3.11.3-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '00331073954e0111f41f7b801662698fb72c16d63080e97704a2a7266e943ca9',
     armv7l: '00331073954e0111f41f7b801662698fb72c16d63080e97704a2a7266e943ca9',
       i686: 'e5d137c3ac7e829a5541e81f0c2824365424cad9cf7177f1f3423434042724ad',
     x86_64: '0851b77d631f6ed42c238765f81d505f616940a2e4612e73d16b2bc8c4173acd'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
