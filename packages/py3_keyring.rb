require 'buildsystems/pip'

class Py3_keyring < Pip
  description 'Keyring stores and accesses your passwords safely.'
  homepage 'https://github.com/jaraco/keyring/'
  version "25.4.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0c34238a10171cf8e567fb26f373b2ea4eec08fe96ad6f06795f94317bfa5b9c',
     armv7l: '0c34238a10171cf8e567fb26f373b2ea4eec08fe96ad6f06795f94317bfa5b9c',
       i686: '9447ce0c29b6a57a042665d041350a7de981ca6dc58e76b40bea3a0d8f222769',
     x86_64: '1afe008d04c9b21f2bf4cbcaa7d6b5424fb7f46f3fda0ffb6a39f694cfbcfc60'
  })

  depends_on 'py3_jeepney'
  depends_on 'py3_secretstorage'
  depends_on 'py3_importlib_metadata'
  depends_on 'python3' => :build

  no_source_build
end
