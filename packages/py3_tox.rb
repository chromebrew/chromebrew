require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.61.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '19f9ce59dd173ca3471955f063fda7d09654e81c4342b215a1274ddbb62c1a3c',
     armv7l: '19f9ce59dd173ca3471955f063fda7d09654e81c4342b215a1274ddbb62c1a3c',
       i686: '71a47d34173181758d32e9d0411051bcaa39d81e2ce3d4ca40fbcb5a55b8a2e1',
     x86_64: '1cd5d08a30ebbbedfe1d94370a3fcca6fc2fcf1cae52643af726a43889f18736'
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
