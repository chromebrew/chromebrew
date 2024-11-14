require 'buildsystems/autotools'

class Isl < Autotools
  description 'Integer Set Library for manipulating sets and relations of integer points bounded by linear constraints'
  homepage 'https://libisl.sourceforge.io/'
  version '0.27'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://libisl.sourceforge.io/isl-#{version}.tar.xz"
  source_sha256 '6d8babb59e7b672e8cb7870e874f3f7b813b6e00e6af3f8b04f7579965643d5c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1be10108b1dca2f1b4a5ec1b3e0327a60afc32f86d6eb18c26b2799aa0e666ec',
     armv7l: '1be10108b1dca2f1b4a5ec1b3e0327a60afc32f86d6eb18c26b2799aa0e666ec',
       i686: 'dcba2fea92e4bc82127c5a31ac1778d195c7255256c36b0ea2e8993577ed5c47',
     x86_64: '913383236bf56e993aff957eeaa93a96478a045ea88adecceea57a3017f307d5'
  })

  depends_on 'glibc' # R
  depends_on 'gmp' # R
end
