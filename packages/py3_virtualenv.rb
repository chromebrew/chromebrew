require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.14.6-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7a1eed1bae44c4054381cbe673bec2e73f4031e984f94d9665b0322ae79a3aea',
     armv7l: '7a1eed1bae44c4054381cbe673bec2e73f4031e984f94d9665b0322ae79a3aea',
       i686: '30d7b635b2d96f3bea830eacef6d4637237b3a8094d961dfc72d62df2ac83486',
     x86_64: 'c0c6e7c4f0e718769f1df89876e6e03be9fbc3b5b0a5a11161b4e4ffa90b2cd6'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
