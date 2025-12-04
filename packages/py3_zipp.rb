require 'buildsystems/pip'

class Py3_zipp < Pip
  description 'Zipp is a backport of pathlib-compatible object wrapper for zip files.'
  homepage 'https://github.com/jaraco/zipp/'
  version "3.23.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2a27c145ae7bbbeecfae5fb4576904334a99477f72ecf90df6909b8cac0b0013',
     armv7l: '2a27c145ae7bbbeecfae5fb4576904334a99477f72ecf90df6909b8cac0b0013',
       i686: '285b12033e9e147a0e72a51a16c1c0905ad9012190facc19ac570f17a24e4b54',
     x86_64: '5c194f61072676c079d29bf38a6095bf0865720a1dd7790e096832a394337e78'
  })

  depends_on 'python3' => :build

  no_source_build
end
