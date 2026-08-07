require 'buildsystems/meson'

class P11kit < Meson
  description "Provides a standard configuration setup for installing PKCS#11 modules in such a way that they're discoverable."
  homepage 'https://p11-glue.github.io/p11-glue/p11-kit.html'
  version '0.26.5'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/p11-glue/p11-kit.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd4587a59bbef8ea59341e0f2dfadee3883a9c9aa00b7e181554a77d0024110ea',
     armv7l: 'd4587a59bbef8ea59341e0f2dfadee3883a9c9aa00b7e181554a77d0024110ea',
       i686: '010642bb6d150d975fe8d3e5545ff60a0e5d5cb8142420d2987dd7b592688aa2',
     x86_64: '8b380a51204b5a4d0ee2f289f8cadbb9d743821d54feff2f9098fa02c2ce6e43'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libffi' => :library
  depends_on 'libtasn1' => :library
end
