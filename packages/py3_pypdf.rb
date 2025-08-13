require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.0.0-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fc40b62db04d95226006bbcaa26b098c420ec763ca8989beeba1f63d7b3b2d34',
     armv7l: 'fc40b62db04d95226006bbcaa26b098c420ec763ca8989beeba1f63d7b3b2d34',
       i686: 'c8ad8f466b60834fb5f607fbb43e70d7e7336bb446e446df95eb24d5bec49b89',
     x86_64: '63d800445739a2efc2e3628295dec1a386a4367b51bd2e7627b39da78f3335ad'
  })

  depends_on 'python3'

  no_source_build
end
