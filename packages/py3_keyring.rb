require 'buildsystems/pip'

class Py3_keyring < Pip
  description 'Keyring stores and accesses your passwords safely.'
  homepage 'https://github.com/jaraco/keyring/'
  version '25.4.1-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0c34238a10171cf8e567fb26f373b2ea4eec08fe96ad6f06795f94317bfa5b9c',
     armv7l: '0c34238a10171cf8e567fb26f373b2ea4eec08fe96ad6f06795f94317bfa5b9c',
       i686: 'f89f139d1db4e6984997f8bac77c4fd5301e669157d23901181fc78cef95e3ca',
     x86_64: '1afe008d04c9b21f2bf4cbcaa7d6b5424fb7f46f3fda0ffb6a39f694cfbcfc60'
  })

  depends_on 'py3_jeepney'
  depends_on 'py3_secretstorage'
  depends_on 'py3_importlib_metadata'
  depends_on 'python3' => :build

  no_source_build
end
