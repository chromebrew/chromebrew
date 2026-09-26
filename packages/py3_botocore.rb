require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.103-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '39d21147e42745c52471aeca1168a950d14ba8e773b902fca7392240afd4488b',
     armv7l: '39d21147e42745c52471aeca1168a950d14ba8e773b902fca7392240afd4488b',
       i686: '1e39cda172418d5d9a49df6623ca5ecf17b4da0a73ca64e05d4eda05522e619b',
     x86_64: '4060e63b79218e397347f97e053036a0b199a621c401c2cea0db667e6f7762c7'
  })

  depends_on 'python3' => :logical

  no_source_build
end
