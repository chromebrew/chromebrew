require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.14-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a3b25a9b9869d8a21fa79ecce22124a8ae597e978efbb74f0365b81987e5116d',
     armv7l: 'a3b25a9b9869d8a21fa79ecce22124a8ae597e978efbb74f0365b81987e5116d',
       i686: '16ddb146cfbbe85ea542612c58a06d6a78c75c2f75ead8805471d4eaf0b6cb74',
     x86_64: '01aaf1290113dda527e06706d00d64deb19fc240c35ff11f4aab906885579978'
  })

  depends_on 'python3' => :logical

  no_source_build
end
