require 'buildsystems/pip'

class Py3_s3transfer < Pip
  description 'An Amazon S3 Transfer Manager'
  homepage 'https://github.com/boto/s3transfer'
  version "0.19.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3e35e2836b1c29042e5aad0efd0024271bb2092296417cc4332c0960cb9852e1',
     armv7l: '3e35e2836b1c29042e5aad0efd0024271bb2092296417cc4332c0960cb9852e1',
       i686: '0076861a18a7caecb88c8b074a66b146a90240ccaa5561ef42b02be9bdebe6dc',
     x86_64: 'e7d6f9017c88673a5c3bb0a452fb9986cdec75c511a4675d22732c19fad8e7a8'
  })

  depends_on 'python3' => :logical

  no_source_build
end
