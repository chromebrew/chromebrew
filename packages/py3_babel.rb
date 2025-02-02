require 'buildsystems/pip'

class Py3_babel < Pip
  description 'Babel is an integrated collection of utilities that assist in internationalizing and localizing Python applications.'
  homepage 'https://babel.pocoo.org/'
  version "2.17.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '495b68135c45c36a8800f959fb4743966afdceff5a88d9687835b79ffbdd3bd8',
     armv7l: '495b68135c45c36a8800f959fb4743966afdceff5a88d9687835b79ffbdd3bd8',
       i686: '9ed5feb0c5171425e1bd85d11e2860d926ccdcb6e4245d103961074b79a2d3bf',
     x86_64: 'cddddf8a4979e7c72e58562f914a67c5fc53e07aa9f10bb7457e8e53ad37c79e'
  })

  depends_on 'py3_pytz'
  depends_on 'python3' => :build

  no_source_build
end
