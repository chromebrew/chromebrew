require 'buildsystems/autotools'

class Appres < Autotools
  description 'The appres program prints the resources seen by an application (or subhierarchy of an application) with the specified class and instance names.'
  homepage 'https://gitlab.freedesktop.org/xorg/app/appres'
  version '1.0.7'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/app/appres.git'
  git_hashtag "appres-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e560503414f7404941a4a0cf7a190684eba3f39c9b528aedd795a714c887fe27',
     armv7l: 'e560503414f7404941a4a0cf7a190684eba3f39c9b528aedd795a714c887fe27',
     x86_64: '8f912366682677618af24ad98abbce774efb3a4f4b1ecb987cd4eaa2b81148d2'
  })

  depends_on 'libx11'
  depends_on 'libxt'
  depends_on 'xorg_proto'
end
