require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.2.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '61381517f1b1fd9e6a1058c3ce07ba3e1097b67f1ed79ab2f9fef6af0d061748',
     armv7l: '61381517f1b1fd9e6a1058c3ce07ba3e1097b67f1ed79ab2f9fef6af0d061748',
       i686: 'd9f95eae8611913a44c960cd57160c6d14557de3a190e96f9a357b9b3cb8276d',
     x86_64: 'fb5facc2b6ab6ef66734cb95f89a506d4b14965c2b7e1625baf019abc4b41457'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
