require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.93-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7782b7cc77cf47a0305e1122dc86c652e62ef5fa0c600108e6513274b43aab84',
     armv7l: '7782b7cc77cf47a0305e1122dc86c652e62ef5fa0c600108e6513274b43aab84',
       i686: 'a0854a703e8b66935e5e0e03c8c3a1a8e0eafcb3f0ee96ce5603717a694d632c',
     x86_64: '5b9776b6ef76778b6bfdee6055aed5ac53ab7b10834ca69c062acaec88fae37a'
  })

  depends_on 'python3' => :logical

  no_source_build
end
