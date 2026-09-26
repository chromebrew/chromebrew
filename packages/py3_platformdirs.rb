require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.11.14-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '117735058bcc85b5ea7be5cf9f00a3b98b0fe7a27bc8b1c885a507cbc28195d1',
     armv7l: '117735058bcc85b5ea7be5cf9f00a3b98b0fe7a27bc8b1c885a507cbc28195d1',
       i686: '142cb82d497c7d11f368508fac0870350db6a51e0a9d20fe93637fd68c6924bb',
     x86_64: 'a45f5a6b78b2ea4db454b04ca8699581de2aab216c5fa887e6968be97bd39d14'
  })

  depends_on 'python3' => :logical

  no_source_build
end
