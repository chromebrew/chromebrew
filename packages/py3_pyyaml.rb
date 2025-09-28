require 'buildsystems/pip'

class Py3_pyyaml < Pip
  description 'PyYAML is a YAML parser and emitter for Python.'
  homepage 'https://pyyaml.org/'
  version "6.0.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cfb1b6c69e7de919460e30a40e2f547f8e9d2cb3e0f0f073271d279d4e99d0c0',
     armv7l: 'cfb1b6c69e7de919460e30a40e2f547f8e9d2cb3e0f0f073271d279d4e99d0c0',
       i686: '2f22f5ba729feebc0b26ff96a13eedfa9fd59a793421b5682aeaf5cfb29cc344',
     x86_64: '2e6addd83396ee4a20819857bb3b9544471d75ed321d4810a6a765c93c08d4be'
  })

  depends_on 'glibc' # R
  depends_on 'libyaml' => :build
  depends_on 'python3' # R

  no_source_build
end
