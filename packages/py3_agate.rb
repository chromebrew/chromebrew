require 'buildsystems/pip'

class Py3_agate < Pip
  description 'Agate is a data analysis library that is optimized for humans instead of machines.'
  homepage 'https://agate.readthedocs.io/'
  version "1.14.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dab0b929ae4e207edebbb2b4101d9b0a1ecf660e8c2119ad57beea2e9c9f53f6',
     armv7l: 'dab0b929ae4e207edebbb2b4101d9b0a1ecf660e8c2119ad57beea2e9c9f53f6',
       i686: 'fc04afaa35716bae2a79f87e4d6118bcc862019aa1d8b0df456cf702fb1598fe',
     x86_64: 'bc43470242195bac1c79581e9f5f6731b6b4e8f5c3d7bd219d01abb59302c85b'
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
