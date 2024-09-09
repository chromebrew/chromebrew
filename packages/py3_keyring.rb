require 'buildsystems/pip'

class Py3_keyring < Pip
  description 'Keyring stores and accesses your passwords safely.'
  homepage 'https://github.com/jaraco/keyring/'
  version '25.3.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1fe2dcfcdf9b7a5447612d60c43bb08a899d7200d2ee255b90dd1542636c255f',
     armv7l: '1fe2dcfcdf9b7a5447612d60c43bb08a899d7200d2ee255b90dd1542636c255f',
       i686: 'bef45b571a56ec5b64ebd663453b911261ff07818da43f91b52bb2cd7b98d3b0',
     x86_64: '8c88721051a53cde22690dbcc84453ee70dfb0a745a025e7e9d6db6472a98140'
  })

  depends_on 'py3_jeepney'
  depends_on 'py3_secretstorage'
  depends_on 'py3_importlib_metadata'
  depends_on 'python3' => :build

  no_source_build
end
