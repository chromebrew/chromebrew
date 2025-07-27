require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.28.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '026eac48cb708ad1044597b219ceec66d39d03740182a07030d14fff73a9b4f2',
     armv7l: '026eac48cb708ad1044597b219ceec66d39d03740182a07030d14fff73a9b4f2',
       i686: '2e44f173ce9cc381c4cfcd8a07b5321f0105b6ea5fce6c73448dc7c1f26a5ecd',
     x86_64: 'd383b6830354168182a59a3fe8601b96ec9c6166418350a457d40eb96b7250f6'
  })

  depends_on 'py3_py'
  depends_on 'py3_filelock'
  depends_on 'py3_six'
  depends_on 'py3_packaging'
  depends_on 'py3_virtualenv'
  depends_on 'py3_pluggy'
  depends_on 'py3_toml'
  depends_on 'python3' => :build

  no_source_build
end
