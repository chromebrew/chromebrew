require 'buildsystems/autotools'

class Attr < Autotools
  description 'Commands for Manipulating Filesystem Extended Attributes.'
  homepage 'https://savannah.nongnu.org/projects/attr'
  version '2.6.0'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/attr.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1446a5efca5a65e2dda6db0bbb3b64f820dc762d6d9abba3244c3afd6b92a7d5',
     armv7l: '1446a5efca5a65e2dda6db0bbb3b64f820dc762d6d9abba3244c3afd6b92a7d5',
       i686: 'd8abeca24be3aa0c70d3ef2e35ea254e7db773d0c64dc32a9fca99f023f8c1da',
     x86_64: 'ac19a0cb4e2175a81f63fdb32bd4d70da57c9968601ffb40db1509e3b71d7593'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libcap' => :build

  no_filefix
end
