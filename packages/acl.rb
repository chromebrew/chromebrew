require 'buildsystems/autotools'

class Acl < Autotools
  description 'Commands for Manipulating POSIX Access Control Lists.'
  homepage 'https://savannah.nongnu.org/projects/acl'
  version '2.3.2'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://git.savannah.nongnu.org/cgit/acl.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '653b625434c8575fea35c39ca5e35af609211c7de54bb2544c62d5b9d835bb2c',
     armv7l: '653b625434c8575fea35c39ca5e35af609211c7de54bb2544c62d5b9d835bb2c',
       i686: '62d6a3760da581987301da062b5da6790eb1f92d8fb5a2b4b54b5cc54293e7d4',
     x86_64: '8ac4dfde9ec567c5ff429b4c47a3e63293e9283d304bcf447b40b7f65be3f589'
  })

  depends_on 'attr'

  no_zstd
end
