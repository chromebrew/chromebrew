require 'buildsystems/pip'

class Py3_dbfread < Pip
  description 'DBFread reads DBF Files with Python.'
  homepage 'https://dbfread.readthedocs.io/'
  version '2.0.7-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c0728bc8bcab54f0a30a2a98ed9cbd23ca97ccbce156743962ef00a424aac7bd',
     armv7l: 'c0728bc8bcab54f0a30a2a98ed9cbd23ca97ccbce156743962ef00a424aac7bd',
       i686: '0ccc60b28d011b6b8a4a56f740712eb318d484619cfd250c5cfbcfc74b3a8cb2',
     x86_64: 'ce1c995899222a566aa4fb9dcc8b6cec1dafca40350ef8d28af6dab83523289f'
  })

  depends_on 'python3' => :build

  no_source_build
end
