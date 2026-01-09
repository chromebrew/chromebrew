require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.34.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd13d136612443c2d642547e5c4beb181e3d6e57bb40ac61a9b49c7e5353b798b',
     armv7l: 'd13d136612443c2d642547e5c4beb181e3d6e57bb40ac61a9b49c7e5353b798b',
       i686: 'ae2b892fa0715121ae0f742b1c6fa526ba49c8e3e7b63b2759284e39b6a91cb2',
     x86_64: '460ad3376ade76c1b7772cf351caead9a67e6a9f20e0367b6af692942d2d8b93'
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
