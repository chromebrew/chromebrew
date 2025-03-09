require 'buildsystems/pip'

class Py3_configparser < Pip
  description 'Configparser backports newer configparser modules to earlier python versions.'
  homepage 'https://github.com/jaraco/configparser/'
  version "7.2.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eeaf8dbb8b15cc00403834ce071c818b7b9aad47e12b5f12ba0242382801e62b',
     armv7l: 'eeaf8dbb8b15cc00403834ce071c818b7b9aad47e12b5f12ba0242382801e62b',
       i686: '6c800d79ae18ab11b737ebb8067d2c9f99242a5382156653a640a6abcc86782e',
     x86_64: 'dae61a67c3ce9d6882f7e9433e721b222eff2866ac260228a1badd448908d508'
  })

  depends_on 'python3' => :build

  no_source_build
end
