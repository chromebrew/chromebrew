require 'buildsystems/pip'

class Py3_python_dateutil < Pip
  description 'Dateutil provides extensions to the standard Python datetime module.'
  homepage 'https://dateutil.readthedocs.io/'
  version '2.9.0.post0-py3.12'
  license 'BSD-3 and Apache-2.0 or BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6a8b6510892e7d480454303db2c5c32527dba91fc6e53bbb2394834eb89583e5',
     armv7l: '6a8b6510892e7d480454303db2c5c32527dba91fc6e53bbb2394834eb89583e5',
       i686: '0652f14a705663b083e963a82a3f7b78696a0dc50cd2b27425e6f14aad17fc83',
     x86_64: '92d4bb70e91e9c3be895205e52ef0d0dd63cf83bb3143ccab5c635172deb6005'
  })

  depends_on 'python3' => :build

  no_source_build
end
