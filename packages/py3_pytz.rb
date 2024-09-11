require 'buildsystems/pip'

class Py3_pytz < Pip
  description 'pytz brings the Olson tz database into Python.'
  homepage 'https://pythonhosted.org/pytz/'
  version '2024.2-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fb5d9ef5e6584dd52363156dfc347c5d316f84823dad9cabea3b98bbb8cb7345',
     armv7l: 'fb5d9ef5e6584dd52363156dfc347c5d316f84823dad9cabea3b98bbb8cb7345',
       i686: '4ce43bee59e32aacd7c8a9307ba37d5a23178235404ccedf365889d07e722870',
     x86_64: '0f68d373ec6ff4fcd1df54a49b700321f1e8021926a9b970472555398763b1d4'
  })

  depends_on 'python3' => :build

  no_source_build
end
