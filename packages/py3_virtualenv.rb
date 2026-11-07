require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.15.6-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a32e722695d195a77a24084740c885dfb02c9214800aa62257ecaf96c99d41ae',
     armv7l: 'a32e722695d195a77a24084740c885dfb02c9214800aa62257ecaf96c99d41ae',
       i686: '9ac994d4d276f7a0852aaa7878312f4770581f25bec31f714d592e05e57b0825',
     x86_64: 'e7cda93c7cdc87e7d1adbddeb203813e96988f091ef38a995e279ab97d82e834'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
