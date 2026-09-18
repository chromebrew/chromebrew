require 'buildsystems/pip'

class Py3_idna < Pip
  description 'IDNA provides internationalized domain names for Python.'
  homepage 'https://github.com/kjd/idna/'
  version "3.20-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '18d05612d8e5704a0d24f56ec18cf9989a0df886ba696011724e13f41a60dca1',
     armv7l: '18d05612d8e5704a0d24f56ec18cf9989a0df886ba696011724e13f41a60dca1',
       i686: '8b0ce30a898c22f82e05ff287f7833be1ddf9374f43e2ff7ef9a5a94bd9de64f',
     x86_64: '8aea709c33e3805a815639ab961b22a93b27dc0e4d98a61b6feb7f27c33b904a'
  })

  depends_on 'python3' => :logical

  no_source_build
end
