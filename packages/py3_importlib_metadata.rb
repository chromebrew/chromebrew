require 'buildsystems/pip'

class Py3_importlib_metadata < Pip
  description 'Importlib metadata reads metadata from Python packages.'
  homepage 'https://github.com/python/importlib_metadata/'
  version '8.4.0-py3.12'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ef9c0941c26107ab72f1b3530cebf0b8f7356bad9386914ac73463288ffdfc11',
     armv7l: 'ef9c0941c26107ab72f1b3530cebf0b8f7356bad9386914ac73463288ffdfc11',
       i686: '35e64ab7f7b8c82a8cf15d7acfeb1edc50f07cfaa64fd328060b7849fce03705',
     x86_64: '2b962a82fc10a42b278e12578f53ff9305cbb0f860144c594c94043a4d62d730'
  })

  depends_on 'py3_zipp'
  depends_on 'python3' => :build

  no_source_build
end
