require 'buildsystems/python'

class Py3_pyte < Python
  description 'PyTE is a Simple VTXXX-compatible terminal emulator.'
  homepage 'https://github.com/selectel/pyte/'
  @_ver = '0.8.1'
  version "#{@_ver}-py3.12"
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/selectel/pyte.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyte/0.8.1-py3.12_armv7l/py3_pyte-0.8.1-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyte/0.8.1-py3.12_armv7l/py3_pyte-0.8.1-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyte/0.8.1-py3.12_i686/py3_pyte-0.8.1-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyte/0.8.1-py3.12_x86_64/py3_pyte-0.8.1-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8dbdf94590e87358c841721e9fd75bf1806e0749d27472daa5ce36a294334190',
     armv7l: '8dbdf94590e87358c841721e9fd75bf1806e0749d27472daa5ce36a294334190',
       i686: 'd07194c7076360c9d404a8f3c5831f378bcbdf1b6fcde157018a401c47bd81bb',
     x86_64: '05155f30c75f0155bfc4f1c332acb858771c3c164632eb5cb35965c3d8b39d38'
  })

  depends_on 'py3_wcwidth'
  depends_on 'python3' => :build
end
