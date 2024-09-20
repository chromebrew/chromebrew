require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version '4.3.6-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '28059357971f8585f6d3a3ce7cee39cb61fd281020d2c02262d382b6b4664de7',
     armv7l: '28059357971f8585f6d3a3ce7cee39cb61fd281020d2c02262d382b6b4664de7',
       i686: 'cd4f834f21a402296735f9db3e55a677286a1032a3ee66255e5595de8ea29f02',
     x86_64: '3254efe1d15503b72fd29f65ff481d04f8f07d343a1a769dc7e71af9cdc7d474'
  })

  depends_on 'python3' => :build

  no_source_build
end
