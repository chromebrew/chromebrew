require 'buildsystems/pip'

class Py3_python_discovery < Pip
  description 'Python interpreter discovery'
  homepage 'https://github.com/tox-dev/python-discovery'
  version "1.4.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0ab8d7bc63fac7ef43499f89551c738401d15153b556cd3482a1f674aab73f29',
     armv7l: '0ab8d7bc63fac7ef43499f89551c738401d15153b556cd3482a1f674aab73f29',
       i686: '92831350cdc7980c5777c41aab5e2594687d6b2aa4bdaf4071f52a4d9b4b5db3',
     x86_64: '4c535dc399a756341990dee209d774820478c6e8b3685d2c30591d1f44a53966'
  })

  depends_on 'python3' => :logical

  no_source_build
end
