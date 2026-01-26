require 'buildsystems/meson'

class P11kit < Meson
  description "Provides a standard configuration setup for installing PKCS#11 modules in such a way that they're discoverable."
  homepage 'https://p11-glue.github.io/p11-glue/p11-kit.html'
  version '0.26.1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/p11-glue/p11-kit.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '74f009921da49b87b6fb9c50f77db5bc4421e82041892df3843793b5dd1cef1b',
     armv7l: '74f009921da49b87b6fb9c50f77db5bc4421e82041892df3843793b5dd1cef1b',
       i686: 'd43ad25c2c6752eccc585ebd049e0e25af5f71e3d3fe9e0bffabbc0f667d25cb',
     x86_64: '6c3136e643f1ac5efa2904cb24c045c0ebac6f82d4d17cd690f7815938e31727'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
