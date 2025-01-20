require 'buildsystems/pip'

class Py3_websockets < Pip
  description ' Library for building WebSocket servers and clients in Python'
  homepage 'https://websockets.readthedocs.io/'
  version "14.2-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a6fbd29abfab19bdfac42a090aaf7179b083e09093fecac12de2f241339165bc',
     armv7l: 'a6fbd29abfab19bdfac42a090aaf7179b083e09093fecac12de2f241339165bc',
       i686: '0c5b35666116b37ed4666e45569a3771f22127dc78221b293fb6471f9da56431',
     x86_64: '58c7e5f0b28cb95ad0a0904e985d5d772fd8ad2d861a1dad58949b5744cff859'
  })

  depends_on 'python3' # L
  depends_on 'glibc' # R

  no_source_build
end
