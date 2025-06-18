require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.27.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '834efc965c97b5de35ca7691468df8e252fb1c7d1c95281e96d957bb8eaec604',
     armv7l: '834efc965c97b5de35ca7691468df8e252fb1c7d1c95281e96d957bb8eaec604',
       i686: 'c78317d5d1d4de744768d839925c19266771bbabde9128da96fe1d53793d3e64',
     x86_64: '8cc029aed166b6c80fea4a690eb56dcf29490d0631e2489dba26e37778d3f24f'
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
