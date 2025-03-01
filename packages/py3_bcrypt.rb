require 'buildsystems/pip'

class Py3_bcrypt < Pip
  description 'Modern password hashing for your software and your servers.'
  homepage 'https://github.com/pyca/bcrypt/'
  version "4.3.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '469fd931b308ffeadd4a90844494ad436f017d3ab6a9eff7af35898c6d3cb7d0',
     armv7l: '469fd931b308ffeadd4a90844494ad436f017d3ab6a9eff7af35898c6d3cb7d0',
       i686: '217b72df520f5d1697686d7beb2c6009fd8d4e63cab2cf984687dadb52a2137f',
     x86_64: '4a76275a9f0387b45c1d35f342d6f6c4bed5698485cc0ccf35a92aeeeafdcd01'
  })

  depends_on 'python3'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'rust' => :build

  no_source_build
end
