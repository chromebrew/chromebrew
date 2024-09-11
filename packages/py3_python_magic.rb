require 'buildsystems/pip'

class Py3_python_magic < Pip
  description 'Magic is a python wrapper for libmagic.'
  homepage 'https://github.com/ahupp/python-magic/'
  version '0.4.27-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7fb7e9e7433ff3dc3adb78b3cb524f61d9945ec2b1451356a6a39e05493c1bea',
     armv7l: '7fb7e9e7433ff3dc3adb78b3cb524f61d9945ec2b1451356a6a39e05493c1bea',
       i686: 'ea5d45f2436cafeb3b0adce3d6b60c9a3a5602cdb67e4d1bf4b7d1627255ee14',
     x86_64: 'd92ac115142b9086971ccd2e87318b44fede5fc484f26caa606fe3972fe75a53'
  })

  depends_on 'filecmd'
  depends_on 'python3' => :build

  no_source_build
end
