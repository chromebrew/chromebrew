require 'buildsystems/pip'

class Py3_python_discovery < Pip
  description 'Python interpreter discovery'
  homepage 'https://github.com/tox-dev/python-discovery'
  version "1.9.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9b5cf0c54e934a5f26eba606c1cb59f7d82c7368ab3f0739b5ef640acf0ba5cf',
     armv7l: '9b5cf0c54e934a5f26eba606c1cb59f7d82c7368ab3f0739b5ef640acf0ba5cf',
       i686: 'fa50496a32323ad09b0e2b73fc0a1906e10e008cb2430dc2cd8ce2dfa593e235',
     x86_64: '8b651643c513325542a64c9eca1536a6d7263be85118de992c459db6624bc573'
  })

  depends_on 'python3' => :logical

  no_source_build
end
