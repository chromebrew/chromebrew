# Adapted from Arch Linux miraclecast PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=miraclecast

require 'package'

class Miraclecast < Package
  description 'MiracleCast provides software to connect external monitors to your system via Wifi. It is compatible to Miracast. Link-management works, everything else is still being worked on. Replaces openwfd. Contribute on https://github.com/albfan/aur-miraclecast'
  homepage 'https://github.com/albfan/miraclecast'
  version 'f3debd'
  license 'GPL'
  compatibility 'all'
  source_url 'https://github.com/albfan/miraclecast.git'
  git_hashtag 'f3debd5678e7699dfd8acfdcc77fda64e9509cae'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/miraclecast/f3debd_armv7l/miraclecast-f3debd-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/miraclecast/f3debd_armv7l/miraclecast-f3debd-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/miraclecast/f3debd_i686/miraclecast-f3debd-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/miraclecast/f3debd_x86_64/miraclecast-f3debd-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8cac01ff5f1b827bca7e15c352a40e221259d3322abe1da53d6a4da6b00b37da',
     armv7l: '8cac01ff5f1b827bca7e15c352a40e221259d3322abe1da53d6a4da6b00b37da',
       i686: '1ebc49e987107f76d74e5102bef2ebe6612853a7d2562b4af50080907058204c',
     x86_64: 'ee247b21fc87f4baa297fc7a1b8d1228fa642917bd7d985c9330685f9fa685cf'
  })

  depends_on 'elogind'
  depends_on 'eudev' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'readline' # R
  depends_on 'gcc' # R

  def self.patch
    system "grep -rl systemd/ | xargs sed -i 's,systemd/,elogind/,g'"
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
