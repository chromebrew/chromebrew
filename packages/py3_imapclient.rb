require 'buildsystems/pip'

class Py3_imapclient < Pip
  description 'IMAPclient is an easy-to-use, complete IMAP client library.'
  homepage 'https://imapclient.readthedocs.io/'
  version "4.3.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a3d18e8ef8b628b78163fa06ab8da90c34db668d77fae060416140832e4f8f0b',
     armv7l: 'a3d18e8ef8b628b78163fa06ab8da90c34db668d77fae060416140832e4f8f0b',
       i686: 'e5347b6b8f385bc5c31f0e52b9c12618dee53cb19e5a60ab9f979154b33ffda5',
     x86_64: '26bb5821cca3b3f3cb1e3c1d163a04a6001f56f68fa600979db60571e71987c5'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
