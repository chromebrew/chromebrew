require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.35.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '655512fbbc8783af54790cf071447e84e5ce717f5e2733d4e5dd80e2cfb05e8d',
     armv7l: '655512fbbc8783af54790cf071447e84e5ce717f5e2733d4e5dd80e2cfb05e8d',
       i686: '8dde328fd12eb314a45e517967ea2f7d0c0bb11b23fb8ddad08747862319e1a7',
     x86_64: '5f89aab6a10013dfe83433294697e87d23bd4cb827e7856e572e0f89a76cff71'
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
