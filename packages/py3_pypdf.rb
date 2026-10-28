require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.21.3-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'feb669e45895987ee38dc31d75847aefe7b8e7bdc460cc88eeea028a826cdf23',
     armv7l: 'feb669e45895987ee38dc31d75847aefe7b8e7bdc460cc88eeea028a826cdf23',
       i686: '550995dcb764876066776fc08d09fd546c37c74ca788d38eb4f86652cd547b72',
     x86_64: '5723dc0eeef437e8784c9dce3648df117e8cd6d43e758b2a38865dfa79bbecb3'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
