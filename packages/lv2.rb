# Adapted from Arch Linux lv2 PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/lv2/trunk/PKGBUILD

require 'buildsystems/meson'

class Lv2 < Meson
  description 'Plugin standard for audio systems'
  homepage 'http://lv2plug.in/'
  version '1.18.10'
  license 'ISC License'
  compatibility 'all'
  source_url 'https://github.com/lv2/lv2.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '16d5251463e96214ebd9bcc2e337d1b10631da34f30bc7d2d277303de992b721',
     armv7l: '16d5251463e96214ebd9bcc2e337d1b10631da34f30bc7d2d277303de992b721',
       i686: '38572e43d8ce731eb183015c48fbe3687e3782c3b349a0d85a57df9730298074',
     x86_64: '66e128bfb3cd4e01aeeb9ae69a05fc0c4851d7297302b867c98f2a5adec4f6ac'
  })

  depends_on 'asciidoc' => :build
  depends_on 'doxygen' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libsndfile' => :build
  depends_on 'py3_pygments' => :build

  meson_options '-Ddocs=disabled \
                 -Dtests=disabled \
                 -Dplugins=disabled'
end
