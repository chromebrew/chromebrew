require 'buildsystems/meson'

class Xorg_proto < Meson
  description 'The xorgproto package provides the header files required to build the X Window system, and to allow other applications to build against the installed X Window system.'
  homepage 'https://www.x.org/'
  version '2024.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/proto/xorgproto.git'
  git_hashtag "xorgproto-#{version}"
  binary_compression 'tar.zst'

  conflicts_ok # conflicts with glproto

  binary_sha256({
    aarch64: '5a3f2d896b21282b35e80fe8c04cced52a3c6767ed2b7f6c1dd507ddb59f94a9',
     armv7l: '5a3f2d896b21282b35e80fe8c04cced52a3c6767ed2b7f6c1dd507ddb59f94a9',
       i686: 'c4f617dd65aeb7853a7c3fb44641ed443255b33e1f5416ca7acf180b3659aa57',
     x86_64: '4691a9ad052fa497074ddad44efb96d4cd8e1c1e10dc41be2820ac53c210899c'
  })
end
