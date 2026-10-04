require 'buildsystems/pip'

class Py3_zipp < Pip
  description 'Zipp is a backport of pathlib-compatible object wrapper for zip files.'
  homepage 'https://github.com/jaraco/zipp/'
  version "4.1.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '95ab25b6f0fcde443898f9d279c1f224d23a84e906e3be25e71648b6b476a824',
     armv7l: '95ab25b6f0fcde443898f9d279c1f224d23a84e906e3be25e71648b6b476a824',
       i686: '58ea3419e7dd1b73d2eb524651aced6dc280520fea9408f0f1e4c1e652297a44',
     x86_64: '3c92979eaaad3bf289c629259f637c88edb751d948563677387773196c9eb2b4'
  })

  depends_on 'python3' => :logical

  no_source_build
end
