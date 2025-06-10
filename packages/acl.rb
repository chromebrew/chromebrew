require 'buildsystems/autotools'

class Acl < Autotools
  description 'Commands for Manipulating POSIX Access Control Lists.'
  homepage 'https://savannah.nongnu.org/projects/acl'
  version '2.3.2-1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/acl.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '76d53a4ba5aaee8c592f9119d7fc29d3b636675c7f7d1642d663b823b87f2303',
     armv7l: '76d53a4ba5aaee8c592f9119d7fc29d3b636675c7f7d1642d663b823b87f2303',
       i686: '8fdb8c78cb4eec75bab8fa77a94cab4968c018285b0b3b98ff006c702dbf3a22',
     x86_64: 'e5b1beae3754bae84e18928c85a6c1c28ee196f387299b51f4cd2ea91dc09645'
  })

  depends_on 'attr'
  depends_on 'glibc' # R
end
