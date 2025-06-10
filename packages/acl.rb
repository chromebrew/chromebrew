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
    aarch64: '653b625434c8575fea35c39ca5e35af609211c7de54bb2544c62d5b9d835bb2c',
     armv7l: '653b625434c8575fea35c39ca5e35af609211c7de54bb2544c62d5b9d835bb2c',
       i686: '8fdb8c78cb4eec75bab8fa77a94cab4968c018285b0b3b98ff006c702dbf3a22',
     x86_64: '8ac4dfde9ec567c5ff429b4c47a3e63293e9283d304bcf447b40b7f65be3f589'
  })

  depends_on 'attr'
  depends_on 'glibc' # R
end
