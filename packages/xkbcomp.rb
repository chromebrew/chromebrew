require 'buildsystems/meson'

class Xkbcomp < Meson
  description 'Compile XKB keyboard'
  homepage 'https://xorg.freedesktop.org/wiki/'
  version '1.4.7-d03a4ab'
  license 'ISC, MIT and custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/app/xkbcomp.git'
  git_hashtag 'd03a4ab1c0b24f6581411622ccf729ceb329aeb8'
  # git_hashtag "xkbcomp-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c654874e78a8da297b0bc5addc3a461e840366bdc333a010db05315f79497329',
     armv7l: 'c654874e78a8da297b0bc5addc3a461e840366bdc333a010db05315f79497329',
     x86_64: '5dbe7bc9bae31c26a4d0cb5a87e1655de43d05ed97307778df49a0b3fbbabaaa'
  })

  depends_on 'mesa' => :build
  depends_on 'xcb_util' => :build

  def self.postinstall
    puts
    puts "xkb configuration files are located in #{CREW_PREFIX}/share/X11/xkb".lightblue
    puts
  end
end
