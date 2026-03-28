require 'buildsystems/pip'

class Py3_agate < Pip
  description 'Agate is a data analysis library that is optimized for humans instead of machines.'
  homepage 'https://agate.readthedocs.io/'
  version "1.14.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9a5847c74dd001dd2f29236985f6f78eba2a65391d07a1b4fde59bccf1043e30',
     armv7l: '9a5847c74dd001dd2f29236985f6f78eba2a65391d07a1b4fde59bccf1043e30',
       i686: '50336215a9b30d0ecff07ae2394bb0327578e0f45d62910db6d6e4ebc0762e3c',
     x86_64: 'c756aad66b9ecd07698ecb2e2714e107b7826bd7451dc0fe4f85c259ffe14e28'
  })

  depends_on 'py3_babel'
  depends_on 'py3_isodate'
  depends_on 'py3_leather'
  depends_on 'py3_parsedatetime'
  depends_on 'py3_pyicu'
  depends_on 'py3_pytimeparse'
  depends_on 'py3_six'
  depends_on 'py3_slugify'
  depends_on 'python3' => :logical

  no_source_build
end
