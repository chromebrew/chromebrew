require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.12.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4ccfef18d351932d5f81186d47cb7fd5655618403fb15d7946e6ece87cd5a5b8',
     armv7l: '4ccfef18d351932d5f81186d47cb7fd5655618403fb15d7946e6ece87cd5a5b8',
       i686: '3eb6ad76f3b476219a94b310cc75775db634a5b5ba81cea1b7cf9b7ec81f5407',
     x86_64: 'fcee38e821f4f635f678775fb5a017387436e001546818f9252bce1fa8f6ea13'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
