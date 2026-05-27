require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.15-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd954c137041b87b473031313d944fe12de4934faf84f0c8e310780dbef68948e',
     armv7l: 'd954c137041b87b473031313d944fe12de4934faf84f0c8e310780dbef68948e',
       i686: '243948795a997bf47fd6139c29ee5481d2625d13a8517482c3266807b9467a79',
     x86_64: '7a671b5cf4fc99d9dedab8bd04b2901b37b98cc4753ae8e662e9ee0c1cf33997'
  })

  depends_on 'python3' => :logical

  no_source_build
end
