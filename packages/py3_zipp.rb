require 'buildsystems/pip'

class Py3_zipp < Pip
  description 'Zipp is a backport of pathlib-compatible object wrapper for zip files.'
  homepage 'https://github.com/jaraco/zipp/'
  version "4.1.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '35c136ff5acd6acf506d4ea208dd5650524d2d00d4fb6456e56769439efefa5a',
     armv7l: '35c136ff5acd6acf506d4ea208dd5650524d2d00d4fb6456e56769439efefa5a',
       i686: '7078601e6db7740906c6c9e59fc5c50edc09cec746859397970872fbc5d4d70b',
     x86_64: 'f88b233de4fef8fc6c8b97bb61bffe23d23e405aface0a8555abbe2cefb83e9c'
  })

  depends_on 'python3' => :logical

  no_source_build
end
