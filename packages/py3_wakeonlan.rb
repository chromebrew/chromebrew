require 'buildsystems/pip'

class Py3_wakeonlan < Pip
  description 'A small python module for wake on lan.'
  homepage 'https://pywakeonlan.readthedocs.io/en/latest/'
  version "4.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6a309c143d79d20d6e7d5ab44b3c0a018e4ae8cfc17c98fd5e7687ced6ca76ec',
     armv7l: '6a309c143d79d20d6e7d5ab44b3c0a018e4ae8cfc17c98fd5e7687ced6ca76ec',
       i686: '1643107ecc9aee7a1920e004914b6a4d35014dcca2b72dd1e8dc64f6fd62708a',
     x86_64: '348d9ec32c1765aca5c2c69530abb29cc5b0ad2e671369958677da688013d0e1'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
