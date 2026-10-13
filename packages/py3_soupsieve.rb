require 'buildsystems/pip'

class Py3_soupsieve < Pip
  description 'CSS selector library designed to be used with Beautiful Soup 4.'
  homepage 'https://github.com/facelessuser/soupsieve'
  version "3.0.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bdc4278da8bb63fd310de03ecd4c7501bf6862a68c56eadc01ea4a29251a8cbe',
     armv7l: 'bdc4278da8bb63fd310de03ecd4c7501bf6862a68c56eadc01ea4a29251a8cbe',
       i686: 'ae1c508319af8e959d9167f9e425d6d7f3913b7d94e750fccd794db5aedee451',
     x86_64: 'd14c9083728a61fc4e8f92829fd2fd94b7ee4f4d22ede3d1704b34dfd4c9fa84'
  })

  depends_on 'python3' => :logical

  no_source_build
end
