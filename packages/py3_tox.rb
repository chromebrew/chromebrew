require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.56.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '767b90d8af0d4240976d15c8104c955c4e3113eb70b134a89f0fb70f203f59ac',
     armv7l: '767b90d8af0d4240976d15c8104c955c4e3113eb70b134a89f0fb70f203f59ac',
       i686: '157335c8efec7b3ead3bc51fce511d76b0e9a72a0e4efa23aa079b4a5cc99e7d',
     x86_64: 'b4d8777274c8876b0b08d380558ac2393fc32da3afa1fd8187c4f58040e57e8c'
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
