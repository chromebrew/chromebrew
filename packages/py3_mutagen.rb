require 'buildsystems/pip'

class Py3_mutagen < Pip
  description 'Python module for handling audio metadata'
  homepage 'https://mutagen.readthedocs.io/'
  @_ver = '1.47.0'
  version "#{@_ver}-py3.12"
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_mutagen/1.47.0-py3.12_armv7l/py3_mutagen-1.47.0-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_mutagen/1.47.0-py3.12_armv7l/py3_mutagen-1.47.0-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_mutagen/1.47.0-py3.12_i686/py3_mutagen-1.47.0-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_mutagen/1.47.0-py3.12_x86_64/py3_mutagen-1.47.0-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8c4c8fc7ae10a0d115cfff58eea2921def5c7bf721d99f9580eb469ff8610a95',
     armv7l: '8c4c8fc7ae10a0d115cfff58eea2921def5c7bf721d99f9580eb469ff8610a95',
       i686: '745220b1085bfcaded2860a99138f5880bfac86c707549a742ae8c6614c52d4b',
     x86_64: 'ee35e39a5ef93b76c3c3cb723c77b1835064eebc0f73366f3da966e2ff747bc7'
  })

  depends_on 'python3' # L
end
