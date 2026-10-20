require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.115-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ded6a446f5dd28282e7cfda3642f72dd93191bc70d6d888090ce5f013e95525a',
     armv7l: 'ded6a446f5dd28282e7cfda3642f72dd93191bc70d6d888090ce5f013e95525a',
       i686: 'd83f4f5eae3e2838d9dd2b08181a8be07fb9e78eecf9b849b8f021f226075623',
     x86_64: 'a4485ce059af6af7a5e1a813d4c9d31bf809f5d44e1d65e4f348ce690be381ea'
  })

  depends_on 'python3' => :logical

  no_source_build
end
