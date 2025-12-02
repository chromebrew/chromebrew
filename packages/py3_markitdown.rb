require 'buildsystems/pip'

class Py3_markitdown < Pip
  description 'Python tool for converting files and office documents to Markdown.'
  homepage 'https://github.com/microsoft/markitdown'
  version "0.1.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '86fb060082676a0f3110287c27b62dfab7a8d99bc72441ada916829d1699defe',
     armv7l: '86fb060082676a0f3110287c27b62dfab7a8d99bc72441ada916829d1699defe',
       i686: 'de40461b7c2e9d1236c4f42aaba6e93692f3bcf226b24469efa5d45f3c665207',
     x86_64: 'db66db97d4932f084600519a322805be2bf18938d6ba78aa8450494278575ce5'
  })

  depends_on 'python3' => :build

  no_source_build
end
