require 'buildsystems/pip'

class Py3_xmltodict < Pip
  description 'XMLtoDict makes working with XML feel like you are working with JSON.'
  homepage 'https://github.com/martinblech/xmltodict/'
  version "1.0.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '77a187bf387994cb88d9faea020cff289430110f8cab13190c4f246f1c366c47',
     armv7l: '77a187bf387994cb88d9faea020cff289430110f8cab13190c4f246f1c366c47',
       i686: '68345ed5dd13012f1b25605538edb900d4c05a0c18bcea2e8857a70f02dfa6a1',
     x86_64: '4cc9e4036f8324608e5b83281e97edc952e9babbec8ee98dbbe8d823e109c35d'
  })

  depends_on 'python3' => :logical

  no_source_build
end
