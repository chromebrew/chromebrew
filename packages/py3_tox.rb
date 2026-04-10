require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.52.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0ac66ff2899dfe47e56570d5e0edab2910528d22f8edb9098edec0d900da8d2d',
     armv7l: '0ac66ff2899dfe47e56570d5e0edab2910528d22f8edb9098edec0d900da8d2d',
       i686: 'c2ad2fb7c757adffc909a3b284e4213a827ead9d52b0bf57f46ff13fb4ff0fcc',
     x86_64: '7eae4a22cf9802bedaaaadcacbaad4b9aa1b778cf5b878d517a3943f406b5e3b'
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
