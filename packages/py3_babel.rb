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
    aarch64: 'bc607d60090ee493148156540793dd8d99fa497ee7d2654ec1a943508a2d25b3',
     armv7l: 'bc607d60090ee493148156540793dd8d99fa497ee7d2654ec1a943508a2d25b3',
       i686: '745e20aa8d6ef22bce49e5d785c4d01889f7bcdbc96c208348b9b6e4e6a017bd',
     x86_64: 'd670ca708d2f217a79f8185bfbca4c33c2a20561731e9ac265235c4e1d51bc0a'
  })

  depends_on 'py3_pytz'
  depends_on 'python3' => :build

  no_source_build
end
