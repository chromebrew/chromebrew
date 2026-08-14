require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.71-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '36a70213bec11d95b38924248b44aa13f617c3ca739e6df6d14b1f6b1f8859de',
     armv7l: '36a70213bec11d95b38924248b44aa13f617c3ca739e6df6d14b1f6b1f8859de',
       i686: '38b6712e6cc1f10571338f57a96c98c58d4af2a9be25ac43602b623705b53fcc',
     x86_64: '235cb403fa23390f2355f9a50c801cc77c4a327a233a2b05c8b0a2c7efb9b39f'
  })

  depends_on 'python3' => :logical

  no_source_build
end
