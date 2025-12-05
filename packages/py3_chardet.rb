require 'buildsystems/pip'

class Py3_chardet < Pip
  description 'Chardet is a universal encoding detector.'
  homepage 'https://github.com/chardet/chardet/'
  version "5.2.0-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2e249afd28800bd05290b8d4adb52aabd253f0a3d51e34559b01af54de4b85fe',
     armv7l: '2e249afd28800bd05290b8d4adb52aabd253f0a3d51e34559b01af54de4b85fe',
       i686: 'eeb2fd9672a6ba1b62ddafd00c9a9d27a01b836fed3c695c3e3890e9408d41b4',
     x86_64: '0da33adb396f8e905fbde1a23d92b74712e8bbcd835ddd97b2ab1b0c851905e1'
  })

  depends_on 'python3' => :build

  no_source_build
end
