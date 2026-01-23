require 'buildsystems/pip'

class Py3_wcwidth < Pip
  description 'WCWidth measures the displayed width of unicode strings in a terminal.'
  homepage 'https://github.com/jquast/wcwidth/'
  version "0.3.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7b675a7a7c6859859c6408add997ebb036aaec6f02f4dbd1176d9cd6ef033cde',
     armv7l: '7b675a7a7c6859859c6408add997ebb036aaec6f02f4dbd1176d9cd6ef033cde',
       i686: '9b8569c3e45f60d04284db57d0712e55426c7ecea0732618fe9a98ba07ace489',
     x86_64: '0530a7913fb519c3e0f2eae8cd1108427dac9686f95f963cfbbef4a06087b69d'
  })

  depends_on 'python3' => :build

  no_source_build
end
