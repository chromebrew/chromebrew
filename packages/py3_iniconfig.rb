require 'buildsystems/pip'

class Py3_iniconfig < Pip
  description 'Iniconfig provides simple config-ini parsing.'
  homepage 'https://github.com/pytest-dev/iniconfig/'
  version '2.0.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '290ea50b7012af7efddc9e0f57de0a443c7fe5bf109c89c3c5e98cb64488d262',
     armv7l: '290ea50b7012af7efddc9e0f57de0a443c7fe5bf109c89c3c5e98cb64488d262',
       i686: '42bea6e117d27111c609ce7a8201c6de638e0c94388f24c956e6f73b4a117cc1',
     x86_64: 'ee7dc4de2a2899571a5bd4f63dfb9aac906e90129f7afc9edb5234d95c1d4162'
  })

  depends_on 'python3' => :build

  no_source_build
end
