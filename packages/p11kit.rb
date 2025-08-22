require 'buildsystems/meson'

class P11kit < Meson
  description "Provides a standard configuration setup for installing PKCS#11 modules in such a way that they're discoverable."
  homepage 'https://p11-glue.github.io/p11-glue/p11-kit.html'
  version '0.25.5'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/p11-glue/p11-kit.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '86f7b8e4370429e3e33f808958df60a2966fca21f72c879ee7f20f1a96cb9bc8',
     armv7l: '86f7b8e4370429e3e33f808958df60a2966fca21f72c879ee7f20f1a96cb9bc8',
       i686: '7e4fd955e42ae2e5de3ca5fe4c18dd327f21c4e29d0ce83e4282062ec61a7abb',
     x86_64: '39e548c36f4a88fac4cc84cb75ce0bf7d902c8b60d80a41d841058f4634d8ea3'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'libtasn1' # R
end
