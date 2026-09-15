require 'buildsystems/pip'

class Py3_sqlalchemy < Pip
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  version "2.0.53-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9f7bc69b9bdcdc803b1838bdcad522b152314afa053b72985adda58b79c54b24',
     armv7l: '9f7bc69b9bdcdc803b1838bdcad522b152314afa053b72985adda58b79c54b24',
       i686: '834940f99dbac8a0c3044b7e81bee86da391f9248b986ee48828e6650d75687c',
     x86_64: '7c44aca3d8aae5a485a768e2a67605410502853671ed6c8c605103eb14b21aee'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
