require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.49-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9240559a10cfba74b6c92e9225a63716a9aef36851aba8c1560eca726a1b8737',
     armv7l: '9240559a10cfba74b6c92e9225a63716a9aef36851aba8c1560eca726a1b8737',
       i686: 'ae37a140d40bd12772f1b9f98878865cdfe945fbc8a50055d5d8c4137ec659cf',
     x86_64: '69b256bfd19afdfd1fd13fe23a6f23f9231d50c7fc20d2539592edd132ec41ee'
  })

  depends_on 'python3' => :build

  no_source_build
end
