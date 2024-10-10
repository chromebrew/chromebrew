require 'buildsystems/pip'

class Py3_soupsieve < Pip
  description 'CSS selector library designed to be used with Beautiful Soup 4.'
  homepage 'https://github.com/facelessuser/soupsieve'
  version "2.6-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3d866d31859db87d4eb5198990d31a57c444699589ed8b336574ef7346547497',
     armv7l: '3d866d31859db87d4eb5198990d31a57c444699589ed8b336574ef7346547497',
       i686: '961379bb0d7a4dd350ba103f7ff7d894f56bdb2e39ea15db74ed0c4da177fb73',
     x86_64: 'aeb77774828534241c0d2f25ec1c45e44ade75bf3cc386c6c1d3e756d8f2187f'
  })

  depends_on 'python3' => :build

  no_source_build
end
