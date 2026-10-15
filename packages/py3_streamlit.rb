require 'buildsystems/pip'

class Py3_streamlit < Pip
  description 'A faster way to build and share data apps'
  homepage 'https://streamlit.io/'
  version "1.66.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a57e4d5773cf23dcb97199c95eb73bcba7a06d55806615854528725d505673be',
     armv7l: 'a57e4d5773cf23dcb97199c95eb73bcba7a06d55806615854528725d505673be',
       i686: '04e85c7d6de6f84a1ef4d5a8bcbabd4c684787a6c91bb5c979b6b8555cb76b89',
     x86_64: '9e86a37f0827ac1d17eb41690d9c3effecf631ca9829528c8f86cd4fe2474fbd'
  })

  depends_on 'python3' => :logical

  no_source_build
end
