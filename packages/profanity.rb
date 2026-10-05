require 'buildsystems/meson'

class Profanity < Meson
  description 'A console based XMPP client'
  homepage 'https://profanity-im.github.io/'
  version '0.18.2'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/profanity-im/profanity.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'baa13608edab17c6091b77c0a8f05540fff5f00b8362cf231bf6699cff88039e',
     armv7l: 'baa13608edab17c6091b77c0a8f05540fff5f00b8362cf231bf6699cff88039e',
     x86_64: '49a3ba5afd8ee7698c16217971ad56ac2c440c9d27cf3ba69002176bb625cbe2'
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
