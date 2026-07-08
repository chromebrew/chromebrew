require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.42-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8b6985071961a7e1ebffffc0a019fe678497bdddbd79e2be28eff828374efb0e',
     armv7l: '8b6985071961a7e1ebffffc0a019fe678497bdddbd79e2be28eff828374efb0e',
       i686: 'a450a891b88bd5b7a180c3df4497fcca68414db464d79694e4944b25b789dfed',
     x86_64: 'af5ad3b24d4328730580f50f7e283755e14e417768979dc62ca67583d6ec0aa7'
  })

  depends_on 'python3' => :logical

  no_source_build
end
