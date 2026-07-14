require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.47-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd028b85e66dfd3070141492c037c7afaa4fd69832539b9090abba876ab59ffba',
     armv7l: 'd028b85e66dfd3070141492c037c7afaa4fd69832539b9090abba876ab59ffba',
       i686: 'd0c7df5bb26a9f127e5f79f8e4f33f2539d5df7cff97a0d42c6e1d2511a731ef',
     x86_64: '49ae28259bf48b3782274b95de41ef709c50b64017cb81dd9e44fc1dc36408a6'
  })

  depends_on 'python3' => :logical

  no_source_build
end
