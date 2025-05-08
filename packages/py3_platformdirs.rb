require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.3.8-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1dba3c10bf7bfdb665ee88a01de8bd52c532e3d2098f6fad0f1dabf749d5fc63',
     armv7l: '1dba3c10bf7bfdb665ee88a01de8bd52c532e3d2098f6fad0f1dabf749d5fc63',
       i686: 'd0856f1804c947f41db8594590a056a7239e7b8ef446cdc40a1f43aa2fb2a42a',
     x86_64: 'b5dfda11fc1e0fbb8dc8fbb8337e84eb27f390fda3e7264042138b569dbc64a6'
  })

  depends_on 'python3' => :build

  no_source_build
end
