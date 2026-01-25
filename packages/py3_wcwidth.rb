require 'buildsystems/pip'

class Py3_wcwidth < Pip
  description 'WCWidth measures the displayed width of unicode strings in a terminal.'
  homepage 'https://github.com/jquast/wcwidth/'
  version "0.3.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b0e78ee204034e4ac3a17783a1a24e3e2be44a59eaaf44c5bf0bf6493e5d64a5',
     armv7l: 'b0e78ee204034e4ac3a17783a1a24e3e2be44a59eaaf44c5bf0bf6493e5d64a5',
       i686: '27c04d65563b4c5424e6bcc101e4077d0d0ddf93968bb4d974c7f5c404982f89',
     x86_64: '19b365a7835da6bb5745075988c3f8e2d6a11132b2d0bb8f0ccedc890a8ddedd'
  })

  depends_on 'python3' => :build

  no_source_build
end
