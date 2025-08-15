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
    aarch64: '664799d544cc47aab938e4de39a96e43264ffbbb5ab602d3e70defbb3dc26513',
     armv7l: '664799d544cc47aab938e4de39a96e43264ffbbb5ab602d3e70defbb3dc26513',
       i686: 'd738cd2620a160e0c2fc50382e4f41f01f567b92145db9ceb865c30c7d247345',
     x86_64: '30deb3912f58fc91e8d1d4465f457cf1ec527d92b16bb506fcf2a546037379b9'
  })

  depends_on 'python3' => :build

  no_source_build
end
