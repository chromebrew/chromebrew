require 'buildsystems/pip'

class Py3_json2xml < Pip
  description 'json to xml converter'
  homepage 'https://json2xml.readthedocs.io/'
  version "6.0.5-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '17ae99b3278c3b2b705eadbf63428c9e4f950a93417a91d17901c4cb1eddf4a5',
     armv7l: '17ae99b3278c3b2b705eadbf63428c9e4f950a93417a91d17901c4cb1eddf4a5',
       i686: '7aa3fd845239d7a09ae9d783f39e752e6bfe528de63d8b257b92e23f8ab4b658',
     x86_64: 'ff4e61a8145127a486e77b78dc37768256a83870fb0537eac4dc71bda4f09155'
  })

  depends_on 'py3_dicttoxml'
  depends_on 'py3_requests'
  depends_on 'py3_xmltodict'
  depends_on 'python3' => :logical

  no_source_build
end
