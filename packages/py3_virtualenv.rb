require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.4.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7690e8960475d1f0a35d465c91ee4ee2f84d2a8aa8c329c4c22630728b687e72',
     armv7l: '7690e8960475d1f0a35d465c91ee4ee2f84d2a8aa8c329c4c22630728b687e72',
       i686: '8594eb246df1ed19456dd6ca1220222a0bdc3aa00422e32b0f74f998f176158a',
     x86_64: '6fe066e9c83800387ea841ef213bd1b45d6625f8abbb855b1120b89d72695c3a'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
