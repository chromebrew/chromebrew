require 'buildsystems/pip'

class Py3_markitdown < Pip
  description 'Python tool for converting files and office documents to Markdown.'
  homepage 'https://github.com/microsoft/markitdown'
  version "0.1.8-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b47a8fe0aee37afc562329756ef5b49ff4cee35eb9d742e77b5eaf2303b6e8e4',
     armv7l: 'b47a8fe0aee37afc562329756ef5b49ff4cee35eb9d742e77b5eaf2303b6e8e4',
       i686: 'ec7d9a57fec25f1c12209d94c3a500a74f56513b1757681479361edef7ace477',
     x86_64: '10cb736c803ed8d4b34417134dfeb27e880734baf6da97b51d18372cfbe434e8'
  })

  depends_on 'python3' => :logical

  no_source_build
end
