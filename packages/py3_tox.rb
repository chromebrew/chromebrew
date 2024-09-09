require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version '4.18.1-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '37275616e448178f7b46d168a7516e196e970b848ec32a5e430a1ed364f1d358',
     armv7l: '37275616e448178f7b46d168a7516e196e970b848ec32a5e430a1ed364f1d358',
       i686: '27f4300a513b61bc5273394eef9559d01411bc48f5a6ed18eb5aeae2fad8b247',
     x86_64: '6ad78e15e05074bbf858d792a9b60b8031451484e756e671549ffce55f2e13e2'
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
