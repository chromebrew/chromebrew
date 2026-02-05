require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.42-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b67bc342629a41de94fd33ee7363e4cbace320f97442909d0bc59b6ed161b3df',
     armv7l: 'b67bc342629a41de94fd33ee7363e4cbace320f97442909d0bc59b6ed161b3df',
       i686: '2dd02b562137fd94a3d8385bccb849abb7a2c1b8ba03d672e5647aaa3d5994f8',
     x86_64: 'cfc4bc207680f45e9f86d401409c999c6ed14152c8020864a60db3c468c1e6af'
  })

  depends_on 'python3' => :build

  no_source_build
end
