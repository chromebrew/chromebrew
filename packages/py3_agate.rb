require 'buildsystems/pip'

class Py3_agate < Pip
  description 'Agate is a data analysis library that is optimized for humans instead of machines.'
  homepage 'https://agate.readthedocs.io/'
  version "1.12.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '918b1d462cecc2f73c2c025bad3b9a01d7bcc9c26012d04b13ce788f1f2c77c3',
     armv7l: '918b1d462cecc2f73c2c025bad3b9a01d7bcc9c26012d04b13ce788f1f2c77c3',
       i686: '8e2d77a3a458265f3d3c3efe0013726f73b360c574edd58b2a9d9707977f8cbe',
     x86_64: 'ff0028da75fa44acffcf17b897e4e93823f4a355277e09c3854253a73d17ceb4'
  })

  depends_on 'py3_babel'
  depends_on 'py3_six'
  depends_on 'py3_pyicu'
  depends_on 'py3_pytimeparse'
  depends_on 'py3_slugify'
  depends_on 'py3_isodate'
  depends_on 'py3_leather'
  depends_on 'py3_parsedatetime'
  depends_on 'python3' => :build

  no_source_build
end
