require 'buildsystems/meson'

class Profanity < Meson
  description 'A console based XMPP client'
  homepage 'https://profanity-im.github.io/'
  version '0.19.0'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/profanity-im/profanity.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c55497c76f32d5825df924cd75c81dd0ca1034e0e5d2f68dedb03fef6edd7681',
     armv7l: 'c55497c76f32d5825df924cd75c81dd0ca1034e0e5d2f68dedb03fef6edd7681',
     x86_64: '6bb42839477b1f7b47f71561fe209ce77651f1bcbcb6fcc07919250256e3f1a8'
  })

  depends_on 'curl' => :executable
  depends_on 'enchant' => :executable
  depends_on 'gdk_pixbuf' => :executable
  depends_on 'glib' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gpgme' => :executable
  depends_on 'gtk2' => :executable
  depends_on 'gtk3' => :executable
  depends_on 'hunspell' => :executable
  depends_on 'libnotify' => :executable
  depends_on 'libotr' => :executable
  depends_on 'libstrophe' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libxscrnsaver' => :executable
  depends_on 'libxss' => :executable
  depends_on 'ncurses' => :executable
  depends_on 'python3' => :executable
  depends_on 'readline' => :executable
  depends_on 'xscreensaver' => :executable

  meson_options ' \
    -Dnotifications=enabled \
    -Dpython-plugins=enabled \
    -Dc-plugins=enabled \
    -Dotr=enabled \
    -Dpgp=enabled \
    -Dxscreensaver=enabled \
    -Dicons-and-clipboard=enabled \
    -Dgdk-pixbuf=enabled \
    -Dspellcheck=enabled'
end
