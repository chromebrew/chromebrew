require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.70-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '68a5c0b74e3c98c5d0c1377b5e37d131fe59aa7c72f02c83f0c26e5ddb564119',
     armv7l: '68a5c0b74e3c98c5d0c1377b5e37d131fe59aa7c72f02c83f0c26e5ddb564119',
       i686: '96ac507b26561d1db43c422f8e8d7490d9b95495c6b90a739bc7124102615287',
     x86_64: '0d47fc34ed1361966bf8f24c58d7852fd29521e4255c2e6cc7743f5045287c5f'
  })

  depends_on 'python3' => :logical

  no_source_build
end
