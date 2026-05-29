require 'buildsystems/pip'

class Py3_s3transfer < Pip
  description 'An Amazon S3 Transfer Manager'
  homepage 'https://github.com/boto/s3transfer'
  version "0.18.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0fbf5773f386e7405bb668a0528a7d5e7f916e0fc8aef53ef581f66808788eae',
     armv7l: '0fbf5773f386e7405bb668a0528a7d5e7f916e0fc8aef53ef581f66808788eae',
       i686: '93284f2ca8e4055963d0b2e6e4c9a08d5bc63e22d73addae81e68162fdb2842e',
     x86_64: '210c4f1ca2a482dc9866f8614120473a39aa4f1104125295095fd20f5cb6dd06'
  })

  depends_on 'python3' => :logical

  no_source_build
end
