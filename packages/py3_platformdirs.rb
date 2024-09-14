require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version '4.3.3-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '73fcb039ea2aec0a866b6ab0d56761f687419a2582f8aa6db25581aea8b44d98',
     armv7l: '73fcb039ea2aec0a866b6ab0d56761f687419a2582f8aa6db25581aea8b44d98',
       i686: 'c940b37a4709fcb8f1cd9507751c28176904aa3192bb1bf663432f01df7acf90',
     x86_64: '337d4664fbe2c47e2b4186e6b8400a51a404fcd65be125d8a96c21e29e45f87f'
  })

  depends_on 'python3' => :build

  no_source_build
end
