require 'buildsystems/autotools'

class Aribb24 < Autotools
  description 'aribb24 is a basic implementation of the ARIB STD-B24 public standard.'
  homepage 'https://github.com/nkoriyama/aribb24/'
  @_ver = '1.0.3'
  version "#{@_ver}-1"
  compatibility 'all'
  license 'LGPL-3'
  source_url 'https://github.com/nkoriyama/aribb24.git'
  git_hashtag "v#{@_ver}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '80476e675586eeb7e06b18f29d716ebdb92cad48ba9f7cc1dbdec384f6eec99c',
     armv7l: '80476e675586eeb7e06b18f29d716ebdb92cad48ba9f7cc1dbdec384f6eec99c',
       i686: '1065aa544418fbd6ea3bf3306fa9195cf98cfd904df01a8b438f58d719074df0',
     x86_64: '6fb662a2d4d31161b0c555f183256f557af7cbd44e31b3de0ab8fe975cbea48f'
  })

  depends_on 'libpng'

  run_tests
end
