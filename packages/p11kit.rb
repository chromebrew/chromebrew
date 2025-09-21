require 'buildsystems/meson'

class P11kit < Meson
  description "Provides a standard configuration setup for installing PKCS#11 modules in such a way that they're discoverable."
  homepage 'https://p11-glue.github.io/p11-glue/p11-kit.html'
  version '0.25.9'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/p11-glue/p11-kit.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '397d330ed19cd3d64a76c36d16c422f1ad41127a05f27d1b2e5e24f9e04086d5',
     armv7l: '397d330ed19cd3d64a76c36d16c422f1ad41127a05f27d1b2e5e24f9e04086d5',
       i686: 'da7553b4949c4031e1a9eaa2be53f49a6e495baeb8c67ecf4ca40bcce0670b22',
     x86_64: '42c351aebf416179699742feb1b2e9ff92a0cb708426831f61133bd381fe12da'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'libtasn1' # R
end
