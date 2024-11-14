require 'buildsystems/autotools'

class Hyphen < Autotools
  description 'hyphenation library to use converted TeX hyphenation patterns'
  homepage 'https://github.com/hunspell/hyphen'
  version '2.8.8-73dd296'
  license 'GPL-2, LGPL-2.1 and MPL-1.1'
  compatibility 'all'
  source_url 'https://github.com/hunspell/hyphen.git'
  git_hashtag '73dd2967c8e1e4f6d7334ee9e539a323d6e66cbd'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7e2e2fdb83d0ffc858f50927f8119566a7709cb7644bbf1002f8e47f050e3a56',
     armv7l: '7e2e2fdb83d0ffc858f50927f8119566a7709cb7644bbf1002f8e47f050e3a56',
       i686: 'fceabb306364839bea4cec6d415a11e4b6b961f64eda2ade1cd5339fd57b0dd0',
     x86_64: 'cae5691f15a004798e42721343845626363a807b0973009edcd415c33b739b5b'
  })

  run_tests
end
