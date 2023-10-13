# Adapted from Arch Linux fcft PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=fcft

require 'package'

class Fcft < Package
  description 'Simple library for font loading and glyph rasterization using FontConfig, FreeType and pixman.'
  homepage 'https://codeberg.org/dnkl/fcft'
  version '2.5.1'
  compatibility 'all'
  source_url 'https://codeberg.org/dnkl/fcft.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fcft/2.5.1_armv7l/fcft-2.5.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fcft/2.5.1_armv7l/fcft-2.5.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fcft/2.5.1_i686/fcft-2.5.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fcft/2.5.1_x86_64/fcft-2.5.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '28f1176a8cece2b6e7464020871a1f543a01b387b107f7ff8eaec0bb525a2745',
     armv7l: '28f1176a8cece2b6e7464020871a1f543a01b387b107f7ff8eaec0bb525a2745',
       i686: '4cfd8382c087dba1f6fa1c1a1eb4f9c1afb925be0176b648f1dec512dc130f79',
     x86_64: '4d5d098327ea62f4f4c9ea534e8f79346602f54acca4af2dc18e03be3b64c224'
  })

  depends_on 'freetype'
  depends_on 'fontconfig'
  depends_on 'harfbuzz'
  depends_on 'utf8proc'
  depends_on 'pixman'
  depends_on 'tllist' => :build

  def self.patch
    # threads.h was introduced in glibc 2.28. This is a workaround for
    # pre-M92 systems.
    return unless LIBC_VERSION < '2.28'

    system 'curl -Lf https://github.com/jtsiomb/c11threads/raw/19abeee43272002301ddece2f7d5df37394bb54f/c11threads.h -o threads.h'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest(File.read('threads.h')) == 'c945fd352449174d3b6107c715b622206ebb81694ac23239637439d78e33ee5a'
  end

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      -Dgrapheme-shaping=enabled \
      -Drun-shaping=enabled \
      builddir"
    system 'meson configure --no-pager builddir'
    system 'samu -C builddir'
  end

  def self.check
    system 'samu -C builddir test'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
