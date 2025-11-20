require 'buildsystems/pip'

class Py3_cfgv < Pip
  description 'Validate configuration and produce human readable error messages.'
  homepage 'https://github.com/asottile/cfgv'
  version "3.5.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '295238680bc9803be9951a5ce40485a23d243b7b8ff20080a6fc43213cd42505',
     armv7l: '295238680bc9803be9951a5ce40485a23d243b7b8ff20080a6fc43213cd42505',
       i686: 'beb6cf7fea5ea6bc05d69cfc1d233b3b3d5f4cc16f74ca659651dca82516285e',
     x86_64: '7280ba8cf9c616be23b856c8fd49ff9663c1d8fbed39dae1070cf833acddfb33'
  })

  depends_on 'python3' => :build

  no_source_build
end
