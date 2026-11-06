require 'buildsystems/pip'

class Py3_streamlit < Pip
  description 'A faster way to build and share data apps'
  homepage 'https://streamlit.io/'
  version "1.67.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3cba1054a3aba7f7f348745003639072934e643c6f4289ba741ee3117c53029b',
     armv7l: '3cba1054a3aba7f7f348745003639072934e643c6f4289ba741ee3117c53029b',
       i686: '20b4653da9e42675d238e4eb5d4c17e961b3125f0f48fb8fc23faa25e42db12b',
     x86_64: '37c6dc041c8372541d157f91dfd5d79f0d66dcc28dd5b2905c1f3787644e5531'
  })

  depends_on 'python3' => :logical

  no_source_build
end
