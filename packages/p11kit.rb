require 'buildsystems/meson'

class P11kit < Meson
  description "Provides a standard configuration setup for installing PKCS#11 modules in such a way that they're discoverable."
  homepage 'https://p11-glue.github.io/p11-glue/p11-kit.html'
  version '0.26.2'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/p11-glue/p11-kit.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5a904994785cbcc6b620f8694d046cf8608659fa2b392bf46cb76c582bfbf732',
     armv7l: '5a904994785cbcc6b620f8694d046cf8608659fa2b392bf46cb76c582bfbf732',
       i686: '348cd844f00f6bf88a679cab26da06db2238f23549cdda59b629a0608222f03d',
     x86_64: 'ea08b352ca16b2b4f8537aaac3459997e4bd422167c8448428730b4c218b0544'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'libtasn1' # R
end
