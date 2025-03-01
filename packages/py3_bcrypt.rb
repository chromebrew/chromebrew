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
       i686: '9df696602e576e35ae8b0408df55d5577f2a1e61718983b4cf615beda9088432',
     x86_64: 'bde3b2e9450974dee000cca76b05b987590a75392e55dcfd3f0cf8bd4142c758'
  })

  depends_on 'python3'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'rust' => :build

  no_source_build
end
