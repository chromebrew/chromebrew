require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.58.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4e91099d2b0a8220a1ebe343951fbb5cf9737afce4919ebac615b202382809b0',
     armv7l: '4e91099d2b0a8220a1ebe343951fbb5cf9737afce4919ebac615b202382809b0',
       i686: '0cc98ce763888d708cd89e8a25d351f82b7e56907295e097e9b7b345d217a9d2',
     x86_64: 'ca6876c45e22cee9f8dd4428556dcf42584d359eff39b39103e23c8223e0a949'
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
