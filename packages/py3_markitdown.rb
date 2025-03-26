require 'buildsystems/pip'

class Py3_markitdown < Pip
  description 'Python tool for converting files and office documents to Markdown.'
  homepage 'https://github.com/microsoft/markitdown'
  version "0.1.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7c5718675c358cb13de16585a048dd74a252adef6f423797eb7f5ac7e46cdb14',
     armv7l: '7c5718675c358cb13de16585a048dd74a252adef6f423797eb7f5ac7e46cdb14',
       i686: '343a66f0474ba2a91973ea5edc4e1b3914df78eba7eabce8d0b148b156de3e7c',
     x86_64: '65c3188399c5ea6ad0eadc9d54c55dbfb7e33b039623747dc78650ba97b8ec1e'
  })

  depends_on 'python3' => :build

  no_source_build
end
