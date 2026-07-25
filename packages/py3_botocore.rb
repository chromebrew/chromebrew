require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.56-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3a59e72a83f8bad388b894d99115c48f0df30a7518c73e3ecc15b70e21ebb5ac',
     armv7l: '3a59e72a83f8bad388b894d99115c48f0df30a7518c73e3ecc15b70e21ebb5ac',
       i686: '3cef2ba308b9f243d8d9fbc4954880bce6b97a64d15c19c8d39aabae1ff39ed3',
     x86_64: 'bd823d285df155081292444175a341a9277fed9b309336490df7d4ebae228f93'
  })

  depends_on 'python3' => :logical

  no_source_build
end
