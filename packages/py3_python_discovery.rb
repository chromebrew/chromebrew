require 'buildsystems/pip'

class Py3_python_discovery < Pip
  description 'Python interpreter discovery'
  homepage 'https://github.com/tox-dev/python-discovery'
  version "1.3.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '15aeb73cf0cee57cbbbf1ac2a632461c9cab73bcdf1e3af721a19b6609ccf1f3',
     armv7l: '15aeb73cf0cee57cbbbf1ac2a632461c9cab73bcdf1e3af721a19b6609ccf1f3',
       i686: '9aba69a9dfac492f00c2da8d1851c70c1b713c8caf15e239c1cc01a8a9a670f9',
     x86_64: '219d79677acbbfb5f9479befc70c13a97c32ecd11b148d9ba8afe1ede54fe02f'
  })

  depends_on 'python3' => :logical

  no_source_build
end
