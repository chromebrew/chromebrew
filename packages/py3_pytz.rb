require 'buildsystems/pip'

class Py3_pytz < Pip
  description 'pytz brings the Olson tz database into Python.'
  homepage 'https://pythonhosted.org/pytz/'
  version "2026.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '62153fe2d6f5096ebf8f15e4b50f3fa1ef04489ec9cd53d6b319133df2202716',
     armv7l: '62153fe2d6f5096ebf8f15e4b50f3fa1ef04489ec9cd53d6b319133df2202716',
       i686: '0008698098cadc29d23d4e7b5724c502b4d7499e66324fc86b4b630f0d2653c5',
     x86_64: 'b99622ef4adf1413aaba44d849ad7b6e5728f2ec7dd45999f1273e5072db9f93'
  })

  depends_on 'python3' => :logical

  no_source_build
end
