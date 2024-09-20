require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version '4.20.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '465ef3c4dde1f82df7b55ef1da77fabf7c10027d651b0456365515f697bb3106',
     armv7l: '465ef3c4dde1f82df7b55ef1da77fabf7c10027d651b0456365515f697bb3106',
       i686: 'd409cc6e5fceac7ddf4140b13254210d08cbc90fa8cf13aee75ffcfafc2dad4f',
     x86_64: '23000f1bf5a5aadd1eb4c260e0bcc66ff6c03cf764a6822c7e506efd32c31fc7'
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
