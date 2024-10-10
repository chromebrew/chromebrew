require 'buildsystems/pip'

class Py3_imagesize < Pip
  description 'Imagesize gets image size from png/jpeg/jpeg2000/gif file.'
  homepage 'https://github.com/shibukawa/imagesize_py/'
  version "1.4.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3c6e1280739d45d927f0a101bd379eb4f3d466d561d3a625be2bf62546ebcb70',
     armv7l: '3c6e1280739d45d927f0a101bd379eb4f3d466d561d3a625be2bf62546ebcb70',
       i686: 'dfeeb2a03ffbc9845080e88e40be71448bc6b12c636cbd246e520fdad6e7ab05',
     x86_64: 'f6838782b48725e7ecc2baa1b8835f248e26e84e798fd194d0a7e15d75c1d315'
  })

  depends_on 'python3' => :build

  no_source_build
end
