require 'buildsystems/pip'

class Py3_markitdown < Pip
  description 'Python tool for converting files and office documents to Markdown.'
  homepage 'https://github.com/microsoft/markitdown'
  version "0.1.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f1935b73945a2e9eae59f92a4a4bc46231e8d2c88d0525bd81381b0a79b37344',
     armv7l: 'f1935b73945a2e9eae59f92a4a4bc46231e8d2c88d0525bd81381b0a79b37344',
       i686: '5f375b8792558b4793f337c26841c827e93f95eda069efc7a85568e3cb7d771e',
     x86_64: '746ded4f38404e68a6e112c5b2140d3c10ef801cc04408ca1093921439b80389'
  })

  depends_on 'python3' => :build

  no_source_build
end
