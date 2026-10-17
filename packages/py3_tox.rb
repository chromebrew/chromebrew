require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.66.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5d307381528fc8b66cd279717b53dd472a951d82281eab70a610c0b2df112ad2',
     armv7l: '5d307381528fc8b66cd279717b53dd472a951d82281eab70a610c0b2df112ad2',
       i686: '907345f87bca587a64af722eb258c4c687792d5eb41b4e128f0bdba044bce9f6',
     x86_64: '8130e0ab2573d471dfb31d7424f9552c5b5822a7c7be4071cb5e756c8a351958'
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
