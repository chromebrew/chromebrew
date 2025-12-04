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
    aarch64: 'e07869b89b473aa62b0d7b3e461e2d1de3a26cdd8b46eaa2cc35a664d41f3ef5',
     armv7l: 'e07869b89b473aa62b0d7b3e461e2d1de3a26cdd8b46eaa2cc35a664d41f3ef5',
       i686: 'c1446c347d59532ee32bc297111ca98064a038f53ab06097705573590a825ebf',
     x86_64: 'f3ac134ebfdf76350e01562280958851b125ba3632096878a7a120eac1523d65'
  })

  depends_on 'py3_pytz'
  depends_on 'python3' => :build

  no_source_build
end
