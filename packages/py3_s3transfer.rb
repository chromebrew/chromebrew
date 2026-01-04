require 'buildsystems/pip'

class Py3_s3transfer < Pip
  description 'An Amazon S3 Transfer Manager'
  homepage 'https://github.com/boto/s3transfer'
  version "0.16.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3d27b10fe7ef65bb1943b2107291b4ba69cd3a96642620fe1dfef81c6e537aad',
     armv7l: '3d27b10fe7ef65bb1943b2107291b4ba69cd3a96642620fe1dfef81c6e537aad',
       i686: 'de029be1adea07d327a839d35798e42e5bf5e7480a2c0852a0ce2d4b486c32ca',
     x86_64: 'cd82dcd71046d749ad4244442def4c4fc4815a14887ce51a1a3dd3a8d78a5a66'
  })

  depends_on 'python3' => :build

  no_source_build
end
