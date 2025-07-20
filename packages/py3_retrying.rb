require 'buildsystems/pip'

class Py3_retrying < Pip
  description 'Retrying simplifies the task of adding retry behavior to just about anything.'
  homepage 'https://github.com/rholder/retrying/'
  version "1.4.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b949dc58356f623a36f55e0c9c3a42613256d52da2e7f3c04e5f2a2b599ea364',
     armv7l: 'b949dc58356f623a36f55e0c9c3a42613256d52da2e7f3c04e5f2a2b599ea364',
       i686: '2bef91ee48c697898fe141cb53ba58f403e8928e3df97a6b4866c322029f4cd6',
     x86_64: '960c396dfd1d5fcdb2cfed0edb4c0526a60f0288c01e5675d60713351a89ebf0'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
