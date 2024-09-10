require 'buildsystems/pip'

class Py3_parsedatetime < Pip
  description 'Parse human-readable date/time strings'
  homepage 'https://github.com/bear/parsedatetime/'
  version '2.6-py3.12'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1d2a1aca1a892bbf697effcf9e7161b28096843b9383ebca0a7306feef0bca4f',
     armv7l: '1d2a1aca1a892bbf697effcf9e7161b28096843b9383ebca0a7306feef0bca4f',
       i686: '54a8db20a22c9c7327f171f599c748c8bc59ad46525779d2e789bad45072cc95',
     x86_64: 'd919a290d840fc54618ef4dfe5941a189336c836ccfc88c62d72a2bb728f702a'
  })

  depends_on 'python3' => :build

  no_source_build
end
