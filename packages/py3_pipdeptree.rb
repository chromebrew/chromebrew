require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version '2.23.3-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3747a9b9ed0f5dcaf078d0ac3ab6b9b375f559eab14018c59b2a629e6e9e3227',
     armv7l: '3747a9b9ed0f5dcaf078d0ac3ab6b9b375f559eab14018c59b2a629e6e9e3227',
       i686: '1d2f4472588e7098a71506dce282322aef11570ef6ba42899bf7f81e63a7fe00',
     x86_64: 'd847369954abe172743928a14474e21193777937458a550f79c6f68c9cbc9ffc'
  })

  depends_on 'python3' => :build

  no_source_build
end
