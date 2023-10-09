# Adapted from Arch Linux lv2 PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/lv2/trunk/PKGBUILD

require 'buildsystems/meson'

class Lv2 < Meson
  description 'Plugin standard for audio systems'
  homepage 'http://lv2plug.in/'
  version '1.18.10'
  compatibility 'all'
  source_url 'https://github.com/lv2/lv2.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lv2/1.18.10_armv7l/lv2-1.18.10-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lv2/1.18.10_armv7l/lv2-1.18.10-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lv2/1.18.10_i686/lv2-1.18.10-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lv2/1.18.10_x86_64/lv2-1.18.10-chromeos-x86_64.tar.zst'
  })
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
