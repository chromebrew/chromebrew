require 'buildsystems/pip'

class Py3_markitdown < Pip
  description 'Python tool for converting files and office documents to Markdown.'
  homepage 'https://github.com/microsoft/markitdown'
  version "0.1.6-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5df79cabaa50b0c6afda8e38631d34a7998b2b7bace2f1b7969e32fe1a53a3b7',
     armv7l: '5df79cabaa50b0c6afda8e38631d34a7998b2b7bace2f1b7969e32fe1a53a3b7',
       i686: '46f822d37371dc384361b39cf1e9c4d6983487fd87efeda5f400db01b5e9e774',
     x86_64: '4bf415626ce7a17f950db8d4422e1e1577fddcd9ac5ee18b7a76d162ec9ccb03'
  })

  depends_on 'python3' => :logical

  no_source_build
end
