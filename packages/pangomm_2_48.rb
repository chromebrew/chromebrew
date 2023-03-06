require 'package'

class Pangomm_2_48 < Package
  description 'pangomm is the official C++ interface for the Pango font layout library.'
  homepage 'https://developer.gnome.org/pangomm/stable/'
  @_ver = '2.50.1'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/pangomm.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pangomm_2_48/2.50.1_armv7l/pangomm_2_48-2.50.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pangomm_2_48/2.50.1_armv7l/pangomm_2_48-2.50.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pangomm_2_48/2.50.1_i686/pangomm_2_48-2.50.1-chromeos-i686.tar.zst',
     x86_64: 'file:///usr/local/tmp/packages/pangomm_2_48-2.50.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2c0c017674e705ceadda84e527a91cf64b8d71e6d4d3c95e8df9709684d2bdfd',
     armv7l: '2c0c017674e705ceadda84e527a91cf64b8d71e6d4d3c95e8df9709684d2bdfd',
       i686: '5413ee536d4fa7d4fe989a53f5330b9aee8069255dc84d69243058b80e42f50a',
     x86_64: '4f137c118d4325099490937fc01c1496d80a5c62bbbe3128af73a812923a9e89'
  })

  depends_on 'cairomm_1_16' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'glibmm_2_68' # R
  depends_on 'glib' # R
  depends_on 'graphite' => :build
  depends_on 'libsigcplusplus3' # R
  depends_on 'mm_common' => :build
  depends_on 'pango' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Dmaintainer-mode=true \
    -Dbuild-documentation=false \
    builddir"
    system 'meson configure builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
