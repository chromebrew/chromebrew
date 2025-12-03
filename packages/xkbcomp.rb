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
    aarch64: '303da70f1671c19e2570c1dcb5117d0bce49591b6133833201509a62b75b4f99',
     armv7l: '303da70f1671c19e2570c1dcb5117d0bce49591b6133833201509a62b75b4f99',
     x86_64: '3afa38d8c71bf0f1fbde7fc0e3a93be5e8c66b86d40c6528172163a1e579ea87'
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
