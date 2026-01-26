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
    aarch64: '490fd0d67f6cab9107b9e7a734a0dec8ef5311bf5839396b324ed4f87801a897',
     armv7l: '490fd0d67f6cab9107b9e7a734a0dec8ef5311bf5839396b324ed4f87801a897',
       i686: '284613d06d8ea0dec3b18baca9d2c0e18c56eb69f32d73da599246f0cb2f0e25',
     x86_64: 'a44ccdb12ffe9eec8a4a36ab7ab6512601c7f4ad18e4c9d0cb89fb1522a46188'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'libtasn1' # R
end
