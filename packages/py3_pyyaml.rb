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
    aarch64: 'ef871a1118662d428064e3b602382523ab26884874e9017d287ca5d196ab70a0',
     armv7l: 'ef871a1118662d428064e3b602382523ab26884874e9017d287ca5d196ab70a0',
       i686: 'f348aacc9c917e66117cb8895a626b56acfafa7206ffb95be6ab1dbd9c392f74',
     x86_64: '9fa0f002069edc840a47efe0858dcff6d78f501ce9185cbd0b65f1a90d448410'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libyaml' => :library
  depends_on 'python3' => :logical

  no_source_build
end
