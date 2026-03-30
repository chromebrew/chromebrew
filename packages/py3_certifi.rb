require 'buildsystems/pip'

class Py3_certifi < Pip
  description 'Certifi provides Mozilla\'s CA Bundle.'
  homepage 'https://certifi.io/'
  version "2026.2.25-#{CREW_PY_VER}"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a64f31528375450bcd969334991320991d163678023fdeae7069d9f30bed3934',
     armv7l: 'a64f31528375450bcd969334991320991d163678023fdeae7069d9f30bed3934',
       i686: 'cb5c709e6b261588586945424463a23c1fd6475e53e547155b654e4a2db55093',
     x86_64: 'fd05a74b68bc4c0543543b2802e91308b86b7b3893d5abaeaeaaf9ac78945731'
  })

  depends_on 'python3' => :logical

  no_source_build
end
