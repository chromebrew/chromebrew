require 'buildsystems/meson'

class Hicolor_icon_theme < Meson
  description 'Icon-theme contains the standard also references the default icon theme called hicolor.'
  homepage 'https://www.freedesktop.org/wiki/Software/icon-theme/'
  version '0.18'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xdg/default-icon-theme'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ff7b95d8f773d8624295f65b8a1a79404ec2e2ae6d62f22ff019695ea6d02b1c',
     armv7l: 'ff7b95d8f773d8624295f65b8a1a79404ec2e2ae6d62f22ff019695ea6d02b1c',
       i686: 'a2e59ec6e33b38dc66a1f565dc9dcc7360bbcdfa3fe8ed4a4500871c64c49a05',
     x86_64: 'c8432fdc7aa1157df9959a928bf8c7a52df4e24db4effe7c855650b101c658cd'
  })
end
