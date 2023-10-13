# Adapted from Arch Linux seatd PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/seatd/trunk/PKGBUILD

require 'package'

class Seatd < Package
  description 'A minimal seat management daemon, and a universal seat management library'
  homepage 'https://sr.ht/~kennylevinsen/seatd/'
  version '0.7.0'
  license 'MIT'
  compatibility 'x86_64 armv7l aarch64'
  source_url 'https://git.sr.ht/~kennylevinsen/seatd/archive/0.7.0.tar.gz'
  source_sha256 '210ddf8efa1149cde4dd35908bef8e9e63c2edaa0cdb5435f2e6db277fafff3c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/seatd/0.7.0_armv7l/seatd-0.7.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/seatd/0.7.0_armv7l/seatd-0.7.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/seatd/0.7.0_x86_64/seatd-0.7.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd2517776467070422094fb45abb5e10505b3180b45f913bae61ea016201ce14a',
     armv7l: 'd2517776467070422094fb45abb5e10505b3180b45f913bae61ea016201ce14a',
     x86_64: '52baaf5104897a144e2fe4e83057a5ed6ad1b0aa5e471c66cf1945eb7c4be18a'
  })

  depends_on 'glibc' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
        -Dlibseat-logind=disabled \
        -Dlibseat-seatd=enabled \
        -Dlibseat-builtin=enabled \
        -Dexamples=disabled \
        -Dserver=enabled \
        builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja install -C builddir"
  end
end
