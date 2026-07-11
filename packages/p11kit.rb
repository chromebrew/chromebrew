require 'buildsystems/meson'

class P11kit < Meson
  description "Provides a standard configuration setup for installing PKCS#11 modules in such a way that they're discoverable."
  homepage 'https://p11-glue.github.io/p11-glue/p11-kit.html'
  version '0.26.4'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/p11-glue/p11-kit.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5c986075d71533b2827618a4bc543db138ba4c20eea937de60a41078c41f9770',
     armv7l: '5c986075d71533b2827618a4bc543db138ba4c20eea937de60a41078c41f9770',
       i686: '415cc14794bf01ae62d4deea8975ae228cf3ceaaf04ccde7b35079880e13bf71',
     x86_64: 'b8b4b2d97c8176768b4e7c91b2e8bac4f84e387973a0460db7c121d9ebe3efe8'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'libffi' => :library
  depends_on 'libtasn1' => :library
end
