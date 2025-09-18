require 'buildsystems/meson'

class P11kit < Meson
  description "Provides a standard configuration setup for installing PKCS#11 modules in such a way that they're discoverable."
  homepage 'https://p11-glue.github.io/p11-glue/p11-kit.html'
  version '0.25.8'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/p11-glue/p11-kit.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cb85440223113385eafa31267941b82267c9efeaa502a03ac16552391d87accc',
     armv7l: 'cb85440223113385eafa31267941b82267c9efeaa502a03ac16552391d87accc',
       i686: '642486cf33ad854336ac53a3ccf21ff826518538b14c4a15cdca07c46a586e45',
     x86_64: '79a5a3d9c76d64b880106ead452c0b01daa9035f4f57ca5d4a510ffa05e13496'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'libtasn1' # R
end
