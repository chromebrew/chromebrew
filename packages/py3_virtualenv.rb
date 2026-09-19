require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.7.15-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cb7e83609a26a338d313c24d7e229624fd94215008b5ac98a8b8343c082a65a3',
     armv7l: 'cb7e83609a26a338d313c24d7e229624fd94215008b5ac98a8b8343c082a65a3',
       i686: 'e73745552431e5dfccbd5f3b60dde6d43ed7933d275782afb2dd502a23f1f817',
     x86_64: '8f26c6aaada5014d2df3bd1dfa2face9e74c6a93fc4abc193837a7b14da4ca50'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
