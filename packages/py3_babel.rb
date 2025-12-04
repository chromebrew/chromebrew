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
       i686: 'c1446c347d59532ee32bc297111ca98064a038f53ab06097705573590a825ebf',
     x86_64: 'cddddf8a4979e7c72e58562f914a67c5fc53e07aa9f10bb7457e8e53ad37c79e'
  })

  depends_on 'py3_pytz'
  depends_on 'python3' => :build

  no_source_build
end
