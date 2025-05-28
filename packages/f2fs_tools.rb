require 'buildsystems/autotools'

class F2fs_tools < Autotools
  description 'Tools for Flash-Friendly File System F2FS'
  homepage 'https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/about/'
  version '1.16.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'afdb0486fb90ffae2dfd3e1c9d04af56c128accf35976e28e63cad76a67f014a',
     armv7l: 'afdb0486fb90ffae2dfd3e1c9d04af56c128accf35976e28e63cad76a67f014a',
       i686: 'e174d3d66e6696cbdae864ee8ab72db32a04becc60e33d66c15ab0e819599c94',
     x86_64: '9b046f6b7fb6bdc5001b2e0362c15e1af0306b3b5f20158295e4680e2ac95593'
  })

  depends_on 'lz4' # R
  depends_on 'lzo'
  depends_on 'util_linux'

  autotools_configure_options '--without-selinux'
end
