require 'buildsystems/pip'

class Py3_streamlit < Pip
  description 'A faster way to build and share data apps'
  homepage 'https://streamlit.io/'
  version "1.65.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '33d55162f582643cf57ac8e2b3875211704e99612304cc6f3da23a73103a70d4',
     armv7l: '33d55162f582643cf57ac8e2b3875211704e99612304cc6f3da23a73103a70d4',
       i686: 'af197297c465cc48b9d1435d28fcd7cbc09678d8b8e40327f47083e687ebc44c',
     x86_64: '1d5b5cb00f1854aef196e7c5e83b88df6c21b2a3d1f9516a895fb8f0c59aa38e'
  })

  depends_on 'python3' => :logical

  no_source_build
end
