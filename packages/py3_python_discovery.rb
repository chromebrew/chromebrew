require 'buildsystems/pip'

class Py3_python_discovery < Pip
  description 'Python interpreter discovery'
  homepage 'https://github.com/tox-dev/python-discovery'
  version "1.4.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f08270253942ffd81695489a4adf5e497bd80f415fd1d74c931a3c8a82858802',
     armv7l: 'f08270253942ffd81695489a4adf5e497bd80f415fd1d74c931a3c8a82858802',
       i686: '1f531acf7b30cd56cef9074428dcafaea9b6d163d41cea4d84196aaa40ea9992',
     x86_64: '35c3bf3c7e865b0f7040508861545e5dc602c6ef5b2cdf4a8279994ad6ae69ba'
  })

  depends_on 'python3' => :logical

  no_source_build
end
