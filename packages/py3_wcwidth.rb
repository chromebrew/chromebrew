require 'buildsystems/pip'

class Py3_wcwidth < Pip
  description 'WCWidth measures the displayed width of unicode strings in a terminal.'
  homepage 'https://github.com/jquast/wcwidth/'
  version "0.3.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '482742f86105570a3eaf55fd95e2eb0c339a7a9dd426debf4ebb9949c897b7bc',
     armv7l: '482742f86105570a3eaf55fd95e2eb0c339a7a9dd426debf4ebb9949c897b7bc',
       i686: 'f0f506d633f2ecf9da3cf6cc612dfb1d3cc3f84eddd798b10723fa3e0ee6c7c7',
     x86_64: '1dd02d1e00a9e81c196869b3f8b784678f2ee08a93903eedaa19c029e7e27b3d'
  })

  depends_on 'python3' => :build

  no_source_build
end
