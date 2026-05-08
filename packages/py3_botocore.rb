require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.6-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'af70e7ee3eefb1118e8b2fab344b23233aee8af84de595166151d4e20e93257d',
     armv7l: 'af70e7ee3eefb1118e8b2fab344b23233aee8af84de595166151d4e20e93257d',
       i686: '35238f6701796e6dc3701823aef1f285587d265dc97424645352f963a1eafdd5',
     x86_64: '40bebe5074e5ffde64d2f769288a85803f38eef4780ad170da5a42c8a238bc95'
  })

  depends_on 'python3' => :logical

  no_source_build
end
