require 'buildsystems/meson'

class Xorg_proto < Meson
  description 'The xorgproto package provides the header files required to build the X Window system, and to allow other applications to build against the installed X Window system.'
  homepage 'https://www.x.org/wiki/'
  version '2024.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/proto/xorgproto.git'
  git_hashtag "xorgproto-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '21d51df41e7ad8c3e1e82aa8a0adc59dd5474729623290471f0f8cfe1eb5bdf6',
     armv7l: '21d51df41e7ad8c3e1e82aa8a0adc59dd5474729623290471f0f8cfe1eb5bdf6',
       i686: 'e0769e918543e31cdcca830eda7bdaf0c99b37e06f1889fc7faa477c09d1d2d4',
     x86_64: 'd78e9ab0fad59e59a520643d1809d188c1b65db23c3f13ffe728ec6a58a1c0dc'
  })

  # This is needed to provide the deprecated printproto specifications required to build libxp, which is itself deprecated.
  meson_options '-Dlegacy=true'
end
