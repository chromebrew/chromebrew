require 'buildsystems/pip'

class Py3_tzlocal < Pip
  description 'Tzlocal provides tzinfo object for the local timezone.'
  homepage 'https://github.com/regebro/tzlocal/'
  version "5.4.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c78401d4b3148d72b6414e30538a607f0505987f31b67becf7c9797227042132',
     armv7l: 'c78401d4b3148d72b6414e30538a607f0505987f31b67becf7c9797227042132',
       i686: 'b87482d019725b825196ec30baaee35228277da3e27e59bc6cfb1c25ca67dd96',
     x86_64: '44eea74fb2b1d68e7eec7204df1c489ef5864dd6348097583e5c14f13aef4a69'
  })

  depends_on 'py3_pytz'
  depends_on 'python3' => :logical

  no_source_build
end
