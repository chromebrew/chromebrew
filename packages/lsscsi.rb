require 'buildsystems/autotools'

class Lsscsi < Autotools
  description 'The lsscsi command lists information about SCSI devices in Linux.'
  homepage 'http://sg.danny.cz/scsi/lsscsi.html'
  version '0.33'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/doug-gilbert/lsscsi.git'
  git_hashtag "r#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a58f691a1a8ab2b5e221037ff8c88a99e1e2a75fa61c6c3d0c67fa3aeae6c61b',
     armv7l: 'a58f691a1a8ab2b5e221037ff8c88a99e1e2a75fa61c6c3d0c67fa3aeae6c61b',
       i686: '9a23053d5583154830ce2121161cc8f3ca51ac763ee626d359ae6f4451de504d',
     x86_64: '73a11678236942ac0dbb3009bb74aaf14a2ae9cf89d7efad23351b42e3ed6572'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
end
