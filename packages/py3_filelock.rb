require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/benediktschmitt/py-filelock/'
  version "3.20.1-#{CREW_PY_VER}"
  license 'Unlicense'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fc11f0f3be72fdd510ed37a6fd402af43939bd928829689ce5e3024739a70305',
     armv7l: 'fc11f0f3be72fdd510ed37a6fd402af43939bd928829689ce5e3024739a70305',
       i686: 'f39e3cf251fb3169d8dbfb4d0c5a8e2bba3a66ad90c856007ba3247903efddd9',
     x86_64: '8107950748c86cbe3d94a1496c298536e9daf5367c3343b02faa32aeace912fa'
  })

  depends_on 'python3' => :build

  no_source_build
end
