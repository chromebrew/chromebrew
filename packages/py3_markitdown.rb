require 'buildsystems/pip'

class Py3_markitdown < Pip
  description 'Python tool for converting files and office documents to Markdown.'
  homepage 'https://github.com/microsoft/markitdown'
  version "0.1.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7c5718675c358cb13de16585a048dd74a252adef6f423797eb7f5ac7e46cdb14',
     armv7l: '7c5718675c358cb13de16585a048dd74a252adef6f423797eb7f5ac7e46cdb14',
       i686: 'abd10523c212b1d29c48933b9883b57a1bb3739b6878764960e407e7fe17fa0b',
     x86_64: '65c3188399c5ea6ad0eadc9d54c55dbfb7e33b039623747dc78650ba97b8ec1e'
  })

  depends_on 'python3' => :build

  no_source_build
end
