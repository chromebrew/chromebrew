require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/benediktschmitt/py-filelock/'
  version "3.19.1-#{CREW_PY_VER}"
  license 'Unlicense'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e1d695b79600257afebda7c93d266d05a17460a719e6a9c0b6bb4f8930c08a42',
     armv7l: 'e1d695b79600257afebda7c93d266d05a17460a719e6a9c0b6bb4f8930c08a42',
       i686: '34381d476a0c7c82362d2e23d92c926503f092a0405f0b878b2f6be706289370',
     x86_64: '3e4090f504a7b3ecc1a35a51449fac01967b04f805d9fa78f816453ea9274707'
  })

  depends_on 'python3' => :build

  no_source_build
end
