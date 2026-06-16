require 'buildsystems/pip'

class Py3_tzlocal < Pip
  description 'Tzlocal provides tzinfo object for the local timezone.'
  homepage 'https://github.com/regebro/tzlocal/'
  version "5.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5c188957798617ad9801d081c01042fd1933920f9706e1d02bb779f8f12f666a',
     armv7l: '5c188957798617ad9801d081c01042fd1933920f9706e1d02bb779f8f12f666a',
       i686: '10cb1a4a825118a74554ccaf92c8e8c6f07ded7766afcfe7c9b920f64243bffb',
     x86_64: '337cc4150280a619f843dac7a3a05977669d4a71d84479f5b3dfdae5ea3c5f06'
  })

  depends_on 'py3_pytz'
  depends_on 'python3' => :logical

  no_source_build
end
