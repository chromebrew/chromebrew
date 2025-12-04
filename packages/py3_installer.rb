require 'buildsystems/pip'

class Py3_installer < Pip
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://installer.readthedocs.io/'
  version "0.7.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd83b056d3e114054ccf394d30a6b11e8aa459f610f62555e158bc36c09ebbc05',
     armv7l: 'd83b056d3e114054ccf394d30a6b11e8aa459f610f62555e158bc36c09ebbc05',
       i686: '590862879ffa7cb19315058fb490dc826489853054ebd46acfc9fcc2e27e3723',
     x86_64: '531bb92b2e1d96e6675f890e5f8d50b7c2103bdb67adf7e83a9b295c9b79ca76'
  })

  depends_on 'python3'

  no_source_build
end
