require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/benediktschmitt/py-filelock/'
  version "3.24.1-#{CREW_PY_VER}"
  license 'Unlicense'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5f2e012b4ad9fe432e3c5ab36ec0540720a3f1409e9db1ee79972dc0ce275aa6',
     armv7l: '5f2e012b4ad9fe432e3c5ab36ec0540720a3f1409e9db1ee79972dc0ce275aa6',
       i686: '0d7b5c096d994e39186a225ce945669da884afabd99d06eb386102bf3803236b',
     x86_64: '10a93859e73d76c11aaded879037da93a2c40c9d48c1de3f4cc201aa9d78ec60'
  })

  depends_on 'python3' => :build

  no_source_build
end
