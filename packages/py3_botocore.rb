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
    aarch64: '6b29cbbaae0e0c7f395d6273512d915e47cf07404ac65c4a7dd758731207ecd5',
     armv7l: '6b29cbbaae0e0c7f395d6273512d915e47cf07404ac65c4a7dd758731207ecd5',
       i686: '06e4699a8fced4cda592d618c5fdbe698e0da7ff430012ba2f6cdfe88220adad',
     x86_64: '8ffcb102846d89c7e690f1a3f9610ea4d19bb5547e8ea4881e1fd2433658b7c0'
  })

  depends_on 'python3' => :build

  no_source_build
end
