require 'buildsystems/pip'

class Py3_toml < Pip
  description 'Toml is a Python Library for Tom\'s Obvious, Minimal Language.'
  homepage 'https://github.com/uiri/toml/'
  version "0.10.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a852416028b413abdab1a6a396dcd93ca04d9938d06b4b56f62ebaf6bc66108d',
     armv7l: 'a852416028b413abdab1a6a396dcd93ca04d9938d06b4b56f62ebaf6bc66108d',
       i686: '84e80409f5a479979c1831a1d481f1dc79d8b44ff1e8508242307a2e29270500',
     x86_64: 'ab2abc1f90884087ee2aff51f1fce44eeb5df01d4a6a2fb25cf92f5f399e00cb'
  })

  depends_on 'python3' => :logical

  no_source_build
end
