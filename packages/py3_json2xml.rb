require 'buildsystems/pip'

class Py3_json2xml < Pip
  description 'json to xml converter'
  homepage 'https://json2xml.readthedocs.io/'
  version "5.4.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '769dc7b868245704a91dfda8685f661f0d5aa1f0cf8c6cb7c6ec38b99eced4a6',
     armv7l: '769dc7b868245704a91dfda8685f661f0d5aa1f0cf8c6cb7c6ec38b99eced4a6',
       i686: 'ad72d34da6faf25a87be394a05c5a2b37b6a4fba03cebbaf685b7ea98c32edf2',
     x86_64: 'dcd26f37268fd10a380ad6eb8e21868b44e1a739759186e9b8e408c1216ba744'
  })

  depends_on 'py3_dicttoxml'
  depends_on 'py3_requests'
  depends_on 'py3_xmltodict'
  depends_on 'python3' => :build

  no_source_build
end
