require 'buildsystems/pip'

class Py3_pytz < Pip
  description 'pytz brings the Olson tz database into Python.'
  homepage 'https://pythonhosted.org/pytz/'
  version "2026.3.post1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0f7877285d545434fbc499d9645bfff78c427f15a095acfecb6177598aa52f18',
     armv7l: '0f7877285d545434fbc499d9645bfff78c427f15a095acfecb6177598aa52f18',
       i686: '28f4fe27745b34bd37010b313c5be25009e21f5c7a2740b4f699e1e65d64894f',
     x86_64: '30b15b066c7a27c7c425b77a6f3b50d035df5f49228f5fb430e29f6ca2cd0abb'
  })

  depends_on 'python3' => :logical

  no_source_build
end
