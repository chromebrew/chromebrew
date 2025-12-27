require 'buildsystems/pip'

class Py3_hatch_vcs < Pip
  description 'A plugin for Hatch that uses your preferred version control system.'
  homepage 'https://github.com/ofek/hatch-vcs'
  version "0.5.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '51d685d15fcd6fb749e90d289cfeeec49de9878b82eee62574d58afe8729f9e3',
     armv7l: '51d685d15fcd6fb749e90d289cfeeec49de9878b82eee62574d58afe8729f9e3',
       i686: 'bc1eef6c54925e21b308e5db5624ec386e1620aa3b37ee9a72622d3f74071fde',
     x86_64: 'c1907fff5322bc662fc1aeff5c80b344fd81d77f56467334d911d921b9cfdb81'
  })

  depends_on 'python3' => :build

  no_source_build
end
