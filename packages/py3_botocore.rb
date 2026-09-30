require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.105-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ef4fde10efe36ca34fc1849ee84941ba2bd55e4a4cc22548a131a1268dcf4be0',
     armv7l: 'ef4fde10efe36ca34fc1849ee84941ba2bd55e4a4cc22548a131a1268dcf4be0',
       i686: '7d8f21d8eea096aa3e49e31f1617c96bcfe12a9ff4a64c6811ee4c000712861b',
     x86_64: 'e3c681558b56c8670c80713fc39ed96ee24ef77691c76f9bc84cf952dcc095df'
  })

  depends_on 'python3' => :logical

  no_source_build
end
