require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.24-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6b3e8c78ea6907ede208572eb222f25756cf009452e3b943db1c31eab879779d',
     armv7l: '6b3e8c78ea6907ede208572eb222f25756cf009452e3b943db1c31eab879779d',
       i686: '41b3980b51e1fc60ab15819d557438c25df0b50aa95120ba447b4f654e12147e',
     x86_64: 'f50ef3a6f710fe98c2a15c8921896c9bd4b91a5167855a4d8c1c9fd2c696290d'
  })

  depends_on 'python3' => :logical

  no_source_build
end
