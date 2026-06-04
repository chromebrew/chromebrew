require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "3.1.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8b21dc52d432b357fd304d22248c080ea5aa834591df8df48ad8487d6f82fff4',
     armv7l: '8b21dc52d432b357fd304d22248c080ea5aa834591df8df48ad8487d6f82fff4',
       i686: 'f2c5f8245df660ac43f29a32f488300a589ebc5a5e1c580964cf263c353dc82e',
     x86_64: 'aed1f37e4ae1d4edf6290314807e7d5c61754077939dfe4a9ff1f18f25a5d1f6'
  })

  depends_on 'python3' => :logical

  no_source_build
end
