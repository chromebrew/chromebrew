require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.12-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a38fe9df9958aab457f0fdb7613cee68add2bca6b09cff7a4111d2f32d30c874',
     armv7l: 'a38fe9df9958aab457f0fdb7613cee68add2bca6b09cff7a4111d2f32d30c874',
       i686: '353050ecc157ff59ce611784da952d1639b1afde35471f50054a17520ade333a',
     x86_64: '4909efb4a4203e60658e90b16e1119dbb05005c704a030e8e3c966b988d50080'
  })

  depends_on 'python3' => :logical

  no_source_build
end
