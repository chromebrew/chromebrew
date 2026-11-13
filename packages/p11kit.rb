require 'buildsystems/meson'

class P11kit < Meson
  description "Provides a standard configuration setup for installing PKCS#11 modules in such a way that they're discoverable."
  homepage 'https://p11-glue.github.io/p11-glue/p11-kit.html'
  version '0.26.6'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/p11-glue/p11-kit.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '17539bbfb758fb2baa031bccd5df49d9f046bf508e42a92ba3826440ad707e41',
     armv7l: '17539bbfb758fb2baa031bccd5df49d9f046bf508e42a92ba3826440ad707e41',
       i686: '500dab16fc7d615271964410df8532135ee0b92d622a7d89753e7f04a6957926',
     x86_64: '1a933a4c15296471b92500eba84c5df34d201fbe3edc5a9d21f43259a186a219'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libffi' => :library
  depends_on 'libtasn1' => :library
end
