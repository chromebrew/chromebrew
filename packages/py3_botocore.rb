require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.109-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9df00ac28dfc8a0802b18581f000b640066e7a8b187d59bf0ebad2b1f9529c7e',
     armv7l: '9df00ac28dfc8a0802b18581f000b640066e7a8b187d59bf0ebad2b1f9529c7e',
       i686: 'bff233e20849d20a2749a64e1bb7f79a55d5fcf9727fdcd47ed070b5a2e3adf0',
     x86_64: '7fb831a54dc4baa0718e9138671587f982d9c0021ad2a79cabfb0d848365a6df'
  })

  depends_on 'python3' => :logical

  no_source_build
end
