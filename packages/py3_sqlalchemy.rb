require 'buildsystems/pip'

class Py3_sqlalchemy < Pip
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  version "2.0.54-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '12c4427acfb6b9fc6a53eb2569fa02dca88a4dc7dc3b9eb074be7818082bd471',
     armv7l: '12c4427acfb6b9fc6a53eb2569fa02dca88a4dc7dc3b9eb074be7818082bd471',
       i686: '1d2b2e5c2c65858fa58897a21a93a3db4aa23668846e89c5ee3a248588fb8183',
     x86_64: 'd53e68791c1e9076962cf23e493ab2eefce299205ef8247833a521b0bbb6c562'
  })

  depends_on 'glibc' => :build
  depends_on 'glibc_lib' => :build
  depends_on 'python3' => :logical

  no_source_build
end
