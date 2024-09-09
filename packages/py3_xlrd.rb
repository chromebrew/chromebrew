require 'buildsystems/pip'

class Py3_xlrd < Pip
  description 'XLRD is a library to extract data from Microsoft Excel (tm) spreadsheet files.'
  homepage 'https://xlrd.readthedocs.io/'
  version '2.0.1-py3.12'
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0120d34f905d1a127bdaa8beb2508a10249597acd9609fb917d489f54a01ea7d',
     armv7l: '0120d34f905d1a127bdaa8beb2508a10249597acd9609fb917d489f54a01ea7d',
       i686: 'c3a90834fe72a55e9de63e34f74a3efe41e8ed327b6671c4a2429723dbaa14f8',
     x86_64: '24f36d66f3206837b6a21a207d8673af10466d1819aa2838a7dc11dfae20b67d'
  })

  depends_on 'python3' => :build

  no_source_build
end
