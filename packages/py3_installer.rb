require 'buildsystems/pip'

class Py3_installer < Pip
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://installer.readthedocs.io/'
  version "1.0.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '21150659cfc21c8c8602ac344e09f38469d0d23ce9c6e638590a21fef799aee7',
     armv7l: '21150659cfc21c8c8602ac344e09f38469d0d23ce9c6e638590a21fef799aee7',
       i686: '711ff963cdd418636495755125a4c934753870336c3d5acfb4e61ce79fe8f3da',
     x86_64: '5dabbe9636f50200bf8097f4e88d7dd223494e619baec63bd6a1c0e6c43804aa'
  })

  depends_on 'python3' => :logical

  no_source_build
end
