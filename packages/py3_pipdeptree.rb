require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "2.30.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fd55c583cac035b988db85f3cc9470f0dca370a3fe39ac307b55aa7f64d8df5b',
     armv7l: 'fd55c583cac035b988db85f3cc9470f0dca370a3fe39ac307b55aa7f64d8df5b',
       i686: '35af4d9c0243c0f6dcc991420e08b5c53c8c747d176835d50bbf84cb8607a83d',
     x86_64: 'd8c6e4c74be9c0b8f381eba64aa86d5b79f462e0264baaf464d7b99ed0da0d04'
  })

  depends_on 'python3' => :build

  no_source_build
end
