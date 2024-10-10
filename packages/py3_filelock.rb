require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/benediktschmitt/py-filelock/'
  version "3.16.1-#{CREW_PY_VER}"
  license 'Unlicense'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '17f533d11a1ff48c8b3b038bbccf920d46457229973815c5f97a96805120e6bb',
     armv7l: '17f533d11a1ff48c8b3b038bbccf920d46457229973815c5f97a96805120e6bb',
       i686: 'a0f10b20767fa373726407817c276bcac4dc8464968fb8c0f4cfded0a4ee6106',
     x86_64: '5b16c88d297d00e9cb3a105f8f3274ffea5d0c3331c0b6d87f05f487e8727c93'
  })

  depends_on 'python3' => :build

  no_source_build
end
