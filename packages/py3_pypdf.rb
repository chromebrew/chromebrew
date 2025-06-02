require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "5.6.0-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7dbf6dbd0f2efa72cecefb46ea84b0054d35a92bc92b57b355fe6b36b7058fd6',
     armv7l: '7dbf6dbd0f2efa72cecefb46ea84b0054d35a92bc92b57b355fe6b36b7058fd6',
       i686: '34449603e2f6fb980bcf4cedde9edd50637b4ceca454e7b6e8e2302bc7a9141c',
     x86_64: 'e6162f4fd1a8a761b916a1d7df952a645a038d4736b965196bcae2e8e701806f'
  })

  depends_on 'python3'

  no_source_build
end
