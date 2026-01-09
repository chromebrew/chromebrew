require 'buildsystems/pip'

class Py3_pathspec < Pip
  description 'Path specification is a utility library for gitignore style pattern matching of file paths.'
  homepage 'https://github.com/cpburnz/python-pathspec'
  version "1.0.2-#{CREW_PY_VER}"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5650c86c54ff92b751341ec5dd3563c9b0a47df3468c89a2731c6d4d8cf88849',
     armv7l: '5650c86c54ff92b751341ec5dd3563c9b0a47df3468c89a2731c6d4d8cf88849',
       i686: '637c6b214dd8002f007aba357c936dc68c72b3700d48c3f659774e0462633e42',
     x86_64: 'c29d9d10eee5314cf42e8099953456ee471d49d2446575f299888db745edab39'
  })

  depends_on 'python3' => :build

  no_source_build
end
