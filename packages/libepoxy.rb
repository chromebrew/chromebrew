require 'buildsystems/meson'

class Libepoxy < Package
  description 'Epoxy is a library for handling OpenGL function pointer management for you'
  homepage 'https://github.com/anholt/libepoxy'
  version '1.5.10'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/anholt/libepoxy.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libepoxy/1.5.5_armv7l/libepoxy-1.5.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libepoxy/1.5.5_armv7l/libepoxy-1.5.5-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libepoxy/1.5.5_i686/libepoxy-1.5.5-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libepoxy/1.5.5_x86_64/libepoxy-1.5.5-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'de87478a3eecf1b1ab3b23441b87ca0c81ee26af507b7223dffb51097aa15e07',
     armv7l: 'de87478a3eecf1b1ab3b23441b87ca0c81ee26af507b7223dffb51097aa15e07',
       i686: '39b1ca812fd683eda89f16a2b9f5be0a63425ea710f31abf5e9f208ba650b986',
     x86_64: 'e2e6aeded9388b562742d958d047365157a7a4965a4b6147bc9178060a789bd6'
  })

  depends_on 'mesa'
  depends_on 'python3'
end
