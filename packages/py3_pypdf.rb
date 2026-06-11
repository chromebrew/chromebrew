require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.13.2-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '424d59e54e144c9e5b3b403b018613924d2ec72875cf7fbda80c74407159c627',
     armv7l: '424d59e54e144c9e5b3b403b018613924d2ec72875cf7fbda80c74407159c627',
       i686: '5a9b0696ff103512084723ce4fec8757bf210613ca758c9286251527009bed0d',
     x86_64: '3f37919e95ae0a53af07d6b6270fa9933e2c40b9bb8834f1e44b9ac05a0a0a90'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
