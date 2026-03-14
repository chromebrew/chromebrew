require 'buildsystems/pip'

class Py3_wakeonlan < Pip
  description 'A small python module for wake on lan.'
  homepage 'https://pywakeonlan.readthedocs.io/en/latest/'
  version "3.1.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6460f7e3005390155b87eaf5071c030c7faf3771f8b349bd88930d09cfa1a283',
     armv7l: '6460f7e3005390155b87eaf5071c030c7faf3771f8b349bd88930d09cfa1a283',
       i686: '9a026c39743053001ba6cc63f999dc3a29744e9d5d97d0dd4ade747a7c5e7c2e',
     x86_64: '37463fc98f07c6235535a368821d8d9595e2638f3a90af860b5d2063609d9e8a'
  })

  depends_on 'python3'

  no_source_build
end
