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

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/aribb24/1.0.3-1_armv7l/aribb24-1.0.3-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/aribb24/1.0.3-1_armv7l/aribb24-1.0.3-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/aribb24/1.0.3-1_i686/aribb24-1.0.3-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/aribb24/1.0.3-1_x86_64/aribb24-1.0.3-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '80476e675586eeb7e06b18f29d716ebdb92cad48ba9f7cc1dbdec384f6eec99c',
     armv7l: '80476e675586eeb7e06b18f29d716ebdb92cad48ba9f7cc1dbdec384f6eec99c',
       i686: '1065aa544418fbd6ea3bf3306fa9195cf98cfd904df01a8b438f58d719074df0',
     x86_64: '6fb662a2d4d31161b0c555f183256f557af7cbd44e31b3de0ab8fe975cbea48f'
  })

  depends_on 'libpng'

  run_tests
end
