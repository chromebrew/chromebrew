require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.3.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aa482131368054224436a5999aaea0a05f33ddc0ac2cdb7d31cfbd1013b564b3',
     armv7l: 'aa482131368054224436a5999aaea0a05f33ddc0ac2cdb7d31cfbd1013b564b3',
       i686: '2a0750974e1ba9e9338b5de4eae76c05661a7414daaf4d98ac6999078e6856d4',
     x86_64: 'c195152690e731e689349cb40f9960979a20d9897b3a80b2eb537baf03c5935a'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
