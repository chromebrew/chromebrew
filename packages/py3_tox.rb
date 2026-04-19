require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.53.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '346527f5a3f67490c602ddc41a19e623412752d8d4bc6128edaafae081cb5ca2',
     armv7l: '346527f5a3f67490c602ddc41a19e623412752d8d4bc6128edaafae081cb5ca2',
       i686: '9d87c8a3df5508c2f47abed4f6a2e8b247e5906b76ad573d5e146807e16904bc',
     x86_64: '4b6314d6422bdd87863850f6668f00cca8bf077758c8602cb99eff3d9547a78b'
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
