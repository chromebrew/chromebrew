require 'buildsystems/pip'

class Py3_pytest < Pip
  description 'Pytest is simple powerful testing with Python.'
  homepage 'https://pytest.org/'
  version "9.1.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8dfd3104da612cfbae0449a010ed71fc660b0b32c8a02c98f2c64cbd62d92b05',
     armv7l: '8dfd3104da612cfbae0449a010ed71fc660b0b32c8a02c98f2c64cbd62d92b05',
       i686: '95bfe0203c8320b36c0b07f5534cc87de0f34465a777b13372004985972ee5de',
     x86_64: '45dd58102c3256ff75d96060c46712f8b7a7c54c7684aaa2a1b351570fe1e139'
  })

  depends_on 'py3_attrs'
  depends_on 'py3_iniconfig'
  depends_on 'py3_packaging'
  depends_on 'py3_pluggy'
  depends_on 'py3_py'
  depends_on 'py3_toml'
  depends_on 'python3' => :logical

  no_source_build
end
