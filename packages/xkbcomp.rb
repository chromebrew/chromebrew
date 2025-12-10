require 'buildsystems/meson'

class Xkbcomp < Meson
  description 'Compile XKB keyboard'
  homepage 'https://xorg.freedesktop.org/wiki/'
  version '1.5.0'
  license 'ISC, MIT and custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/app/xkbcomp.git'
  git_hashtag "xkbcomp-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'af9060fe631be0a03696a5184424075e79322784837b6854db583c297236fdfc',
     armv7l: 'af9060fe631be0a03696a5184424075e79322784837b6854db583c297236fdfc',
     x86_64: '7c6a616ab9279147174a9b3f5e4b2060e4cce9ac1164a987420df743580ad60f'
  })

  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'libxkbfile' # R
  depends_on 'mesa' => :build
  depends_on 'xcb_util' => :build

  def self.postinstall
    puts
    puts "xkb configuration files are located in #{CREW_PREFIX}/share/X11/xkb".lightblue
    puts
  end
end
