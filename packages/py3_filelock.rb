require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/benediktschmitt/py-filelock/'
  version "3.20.3-#{CREW_PY_VER}"
  license 'Unlicense'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fd45356b9aca95288f50b8627ac3548eb8491f45551213c82a224c7a660f145a',
     armv7l: 'fd45356b9aca95288f50b8627ac3548eb8491f45551213c82a224c7a660f145a',
       i686: '7180266ac5df00e5e13ffadd47ac48efe4755c1e1dae20788205a1d5d7a69c6b',
     x86_64: 'cdb0440837d53ec77235a696ebd98152459ebd111d5bf09cfe8e9955b5901b37'
  })

  depends_on 'python3' => :build

  no_source_build
end
