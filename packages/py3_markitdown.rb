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
    aarch64: '5da3f9f59e0bcbd4d232013063e6fb0a18e333c07dfc96b4831c3db11877b4b3',
     armv7l: '5da3f9f59e0bcbd4d232013063e6fb0a18e333c07dfc96b4831c3db11877b4b3',
       i686: 'abd10523c212b1d29c48933b9883b57a1bb3739b6878764960e407e7fe17fa0b',
     x86_64: '1f3f916388ad41cf24d445f4e430c4aba996425ef892c20ca2a45589e8097b75'
  })

  depends_on 'python3' => :build

  no_source_build
end
