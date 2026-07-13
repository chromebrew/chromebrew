require 'buildsystems/autotools'

class Acl < Autotools
  description 'Commands for Manipulating POSIX Access Control Lists.'
  homepage 'https://savannah.nongnu.org/projects/acl'
  version '2.4.0'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/acl.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6d824c066f8631b85d61a55586b9f69b1752ae6fd6893a818570ff020a1e6040',
     armv7l: '6d824c066f8631b85d61a55586b9f69b1752ae6fd6893a818570ff020a1e6040',
       i686: '159faf982b56fd073b7ba9af23f412b111f4b1f13d035c7ce4f8775fd5b89fd8',
     x86_64: 'f3c3aafa1e5b02c7ad050cb6e0101ef05eac34e4fc518535372fef560d99669a'
  })

  depends_on 'attr' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
end
