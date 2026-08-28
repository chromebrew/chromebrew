require 'buildsystems/pip'

class Py3_scons < Pip
  description 'SCons is an Open Source software construction tool that is, a next-generation build tool.'
  homepage 'https://scons.org/'
  license 'MIT'
  version '4.11.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '793a5db70774329e02984894f817b792dcf03bde7d8f64c5df09a7235d32f0ad',
     armv7l: '793a5db70774329e02984894f817b792dcf03bde7d8f64c5df09a7235d32f0ad',
       i686: 'a90c8fc82b7e8335fa4372588592de5727e1dd8cab1c82273d6bb109671f88cd',
     x86_64: 'f9a17d775f2ed5572ce8e03158cc28facacfccd2e08882cdd9de8d5977df493b'
  })

  depends_on 'python3' => :logical
  no_source_build
end
