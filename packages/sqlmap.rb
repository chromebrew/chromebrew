require 'buildsystems/pip'

class Sqlmap < Pip
  description 'sqlmap is an open source penetration testing tool that automates the process of detecting and exploiting SQL injection flaws and taking over of database servers.'
  homepage 'https://sqlmap.org/'
  version "1.9.8-#{CREW_PY_VER}"
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd9d873ca9f2d228f6a0e95a18a7181ad2cc93c55383d67d6569a8329d4a4c426',
     armv7l: 'd9d873ca9f2d228f6a0e95a18a7181ad2cc93c55383d67d6569a8329d4a4c426',
       i686: '3f1bd2c0d61e51a3e9fe9b90187f1c527bce64a38935f96a6cc646232351751e',
     x86_64: 'de89c085a0bd142d2220c1117ae8126605b572f6d23beb106b292f4f6b6a8bcf'
  })

  depends_on 'python3', '>= 3.12.0'

  no_source_build
end
