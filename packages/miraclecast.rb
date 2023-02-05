# Adapted from Arch Linux miraclecast PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=miraclecast

require 'package'

class Miraclecast < Package
  description 'MiracleCast provides software to connect external monitors to your system via Wifi. It is compatible to Miracast. Link-management works, everything else is still being worked on. Replaces openwfd. Contribute on https://github.com/albfan/aur-miraclecast'
  homepage 'https://github.com/albfan/miraclecast'
  version 'f3debd-1'
  license 'GPL'
  compatibility 'all'
  source_url 'https://github.com/albfan/miraclecast.git'
  git_hashtag 'f3debd5678e7699dfd8acfdcc77fda64e9509cae'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/miraclecast/f3debd-1_armv7l/miraclecast-f3debd-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/miraclecast/f3debd-1_armv7l/miraclecast-f3debd-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/miraclecast/f3debd-1_i686/miraclecast-f3debd-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/miraclecast/f3debd-1_x86_64/miraclecast-f3debd-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9bf27cd31a2f954b04bf69d46502f24aefc5d0f19434a210013250838ec5fdca',
     armv7l: '9bf27cd31a2f954b04bf69d46502f24aefc5d0f19434a210013250838ec5fdca',
       i686: '210d3b2a307f39b16630217e0490102bd8c35b80abef248e850facef8703b4dc',
     x86_64: 'ee12795967f9de44c27aea232a53b0e181e0eae7b7172efdc2fa80c15018cefe'
  })

  depends_on 'chromaprint' # R
  depends_on 'elogind' # R
  depends_on 'eudev' # R
  depends_on 'ffmpeg' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'llvm' # L
  depends_on 'gstreamer' # R
  depends_on 'pygobject' # L
  depends_on 'readline' # R

  def self.patch
    system "grep -rl systemd/ | xargs sed -i 's,systemd/,elogind/,g'"
    system "grep -rl /usr/bin/python3 | xargs sed -i 's,/usr/bin/python3,#{CREW_PREFIX}/bin/python3,g'"
  end

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      -Denable-systemd=false \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
