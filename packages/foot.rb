# Adapted from Arch Linux foot PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=foot

require 'package'

class Foot < Package
  description 'Wayland terminal emulator - fast, lightweight and minimalistic'
  homepage 'https://codeberg.org/dnkl/foot'
  version '1.10.3'
  compatibility 'all'
  source_url 'https://codeberg.org/dnkl/foot.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/foot/1.10.3_armv7l/foot-1.10.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/foot/1.10.3_armv7l/foot-1.10.3-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/foot/1.10.3_i686/foot-1.10.3-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/foot/1.10.3_x86_64/foot-1.10.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '3d452085480e5439a082ef18e3c98fe334db9baed0d361d09fb4c658073e3f2e',
     armv7l: '3d452085480e5439a082ef18e3c98fe334db9baed0d361d09fb4c658073e3f2e',
       i686: '5785c65916a60a59fb8afa793a867baed0f24c64860f88a525870610a3fada0f',
     x86_64: '73cb08a9df0cc25858a2cad4a2b2d5d299dc3f5a430c4d82771af2385447c9ea'
  })

  depends_on 'libxkbcommon'
  depends_on 'wayland'
  depends_on 'pixman'
  depends_on 'fontconfig'
  depends_on 'utf8proc'
  depends_on 'ncurses'
  depends_on 'fcft'
  depends_on 'wayland_protocols' => ':build'
  depends_on 'tllist' => ':build'

  def self.patch
    # threads.h was introduced in glibc 2.28. This is a workaround for
    # pre-M92 systems.
    return unless LIBC_VERSION < '2.28'

    system 'curl -Lf https://github.com/jtsiomb/c11threads/raw/19abeee43272002301ddece2f7d5df37394bb54f/c11threads.h -o threads.h'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('threads.h') ) == 'c945fd352449174d3b6107c715b622206ebb81694ac23239637439d78e33ee5a'
    # Older kernel versions do not have linux header input-event-codes.h Use libc version as a proxy for linux header version.
    return unless LIBC_VERSION < '2.27'

    FileUtils.mkdir 'linux'
    FileUtils.ln_s "#{CREW_PREFIX}/include/linux/input.h", 'linux/input-event-codes.h'
  end

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
      -Dterminfo=disabled \
      -Dthemes=false \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
