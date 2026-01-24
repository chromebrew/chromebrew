require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.34-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9085e37d653330dfe635166bab9b3e91264d81994b7fdb34c679f9613e7e3501',
     armv7l: '9085e37d653330dfe635166bab9b3e91264d81994b7fdb34c679f9613e7e3501',
       i686: '3e3b260db07ed61058c3c7aa33b898051f79b448e4667a84136376b829cba7f2',
     x86_64: 'ec2248ea7e34d5acf38bf52c0e0948ba7aa30b1f99e99989723a3260e5e63cc0'
  })

  depends_on 'python3' => :build

  no_source_build
end
