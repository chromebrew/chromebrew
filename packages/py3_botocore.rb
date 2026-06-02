require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.19-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9803f9410a61d884cab1ddccd5fb7bafb9df419f7cb60cf76654d6c7e2b2840e',
     armv7l: '9803f9410a61d884cab1ddccd5fb7bafb9df419f7cb60cf76654d6c7e2b2840e',
       i686: '79789a95de066dfb344ee8eb35b13fb75263e4b4053bcd72262930669b83a1bc',
     x86_64: 'bec8966bcdc9f1a299b342d4624211f791ac59e76ecd129618d9f80d9cd9a2e9'
  })

  depends_on 'python3' => :logical

  no_source_build
end
