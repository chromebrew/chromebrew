require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.58-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '278ee9707eb8b126c3e58735fc3e0e36862576db9343e6242523ca9ae8116809',
     armv7l: '278ee9707eb8b126c3e58735fc3e0e36862576db9343e6242523ca9ae8116809',
       i686: '558edde13359c1b9607212f5176a4be7ee37cb96b08af62a43e6f7c40e6e8089',
     x86_64: 'fe20a9ec1add69a06c7bf66b7b99a8021fac4e8460bdfc2a92b581b6f24b6e5c'
  })

  depends_on 'python3' => :logical

  no_source_build
end
