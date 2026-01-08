require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "20.36.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9f7cea5c8371493b14fdef4dd926336a6cd699e250fbbf8fd8df75ad7ef68468',
     armv7l: '9f7cea5c8371493b14fdef4dd926336a6cd699e250fbbf8fd8df75ad7ef68468',
       i686: '2aa328cbaca3a821f1b4c924868295c19673bf2e85349642b04cf3b9d1a92509',
     x86_64: 'c71a2c840ef56c01a861f125f2488367f205f9ffa4a5478743998f5b8cb4bd85'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
