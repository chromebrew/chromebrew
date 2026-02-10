require 'buildsystems/pip'

class Py3_markdown < Pip
  description 'Markdown is a Python implementation of Markdown.'
  homepage 'https://python-markdown.github.io/'
  version "3.10.2-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ff38981abdb4186c4f6efa70713d223023899b5bace1159c7c6a76c3c2eff19d',
     armv7l: 'ff38981abdb4186c4f6efa70713d223023899b5bace1159c7c6a76c3c2eff19d',
       i686: 'dde1c8ac61ef4f5ee82a3c6e7cbf61ec5aab47f58a4f31195be8f5d9d12fef36',
     x86_64: 'fa6a52afb2f062338fdf79fb21a4cb65bbf3b5a1504b4c80937edb8582eb0d19'
  })

  depends_on 'python3'

  no_source_build
end
