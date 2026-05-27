require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.12.2-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9725db5c7725719a179782fa229c48a01e0f8435a4327b1d878e60c93d7f02e2',
     armv7l: '9725db5c7725719a179782fa229c48a01e0f8435a4327b1d878e60c93d7f02e2',
       i686: '90078f58d522222130167a38bbd0d5561dfaf430ce85e37eb3b329d72e8bfad7',
     x86_64: '2721f93a2f1ec8a65ad4d6e9ea5fe7adc531318c4dd049ec813fa1b530447773'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
