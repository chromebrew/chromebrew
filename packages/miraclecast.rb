# Adapted from Arch Linux miraclecast PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=miraclecast

require 'package'

class Miraclecast < Package
  description 'MiracleCast provides software to connect external monitors to your system via Wifi. It is compatible to Miracast. Link-management works, everything else is still being worked on. Replaces openwfd. Contribute on https://github.com/albfan/aur-miraclecast'
  homepage 'https://github.com/albfan/miraclecast'
  version 'f3debd-2'
  license 'GPL'
  compatibility 'all'
  source_url 'https://github.com/albfan/miraclecast.git'
  git_hashtag 'f3debd5678e7699dfd8acfdcc77fda64e9509cae'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/miraclecast/f3debd-2_armv7l/miraclecast-f3debd-2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/miraclecast/f3debd-2_armv7l/miraclecast-f3debd-2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/miraclecast/f3debd-2_i686/miraclecast-f3debd-2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/miraclecast/f3debd-2_x86_64/miraclecast-f3debd-2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0f33609529937cecfe387a4e289ffa1fc3c488dfd04088ab0000ee7f3c4d3c39',
     armv7l: '0f33609529937cecfe387a4e289ffa1fc3c488dfd04088ab0000ee7f3c4d3c39',
       i686: '8cef0147176f8390b422781639548334aeaed33c2e866273803e66d02f40f34c',
     x86_64: '84a596f6a8201142136276f2a76211113a8138871c41452f734a27b99026536b'
  })

  depends_on 'chromaprint' # R
  depends_on 'elogind' # R
  depends_on 'eudev' # R
  depends_on 'ffmpeg' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gstreamer' # R
  depwnds_on 'llvm' # R
  depends_on 'pygobject' # L
  depends_on 'readline' # R

  def self.patch
    system "grep -rl systemd/ | xargs sed -i 's,systemd/,elogind/,g'"
    system "grep -rl /usr/bin/python3 | xargs sed -i 's,/usr/bin/python3,#{CREW_PREFIX}/bin/python3,g'"
  end

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      -Dsysconfdir=#{CREW_PREFIX}/etc \
      -Denable-systemd=false \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
