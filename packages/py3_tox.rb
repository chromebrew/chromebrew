require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.52.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ab29b48459e408e744225f153d981d62eb51bbc48ae35232e061e4e9192c4202',
     armv7l: 'ab29b48459e408e744225f153d981d62eb51bbc48ae35232e061e4e9192c4202',
       i686: '7527bf3c046b9bef64cc60c84c8c883c27f12b03d686b285d2374acba586c498',
     x86_64: '5663b91a532478f91321acec3574ff19663e6e9d0f9f22de63f97e01aa0e48c1'
  })

  depends_on 'py3_filelock'
  depends_on 'py3_packaging'
  depends_on 'py3_pluggy'
  depends_on 'py3_py'
  depends_on 'py3_six'
  depends_on 'py3_toml'
  depends_on 'py3_virtualenv'
  depends_on 'python3' => :logical

  no_source_build
end
