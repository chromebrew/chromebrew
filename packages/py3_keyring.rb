require 'buildsystems/pip'

class Py3_keyring < Pip
  description 'Keyring stores and accesses your passwords safely.'
  homepage 'https://github.com/jaraco/keyring/'
  version "25.7.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b9b77526c47b754545534e27e72ec10864eb3320806703021909ba2e7e6fb811',
     armv7l: 'b9b77526c47b754545534e27e72ec10864eb3320806703021909ba2e7e6fb811',
       i686: '608812d51f9bcbd5d921329193c153b0fbd910756431e29390d1f6ec9a407688',
     x86_64: '216fd7b6f04d3b20ef157d4dd74b0293d482b42ceb5e5f3330cd12f1c9e6fd04'
  })

  depends_on 'py3_jeepney'
  depends_on 'py3_secretstorage'
  depends_on 'py3_importlib_metadata'
  depends_on 'python3' => :build

  no_source_build
end
