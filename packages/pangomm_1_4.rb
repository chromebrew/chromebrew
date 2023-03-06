require 'package'

class Pangomm_1_4 < Package
  description 'pangomm is the official C++ interface for the Pango font layout library.'
  homepage 'https://developer.gnome.org/pangomm/stable/'
  @_ver = '2.46.3'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/pangomm.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pangomm_1_4/2.46.3_armv7l/pangomm_1_4-2.46.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pangomm_1_4/2.46.3_armv7l/pangomm_1_4-2.46.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pangomm_1_4/2.46.3_i686/pangomm_1_4-2.46.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pangomm_1_4/2.46.3_x86_64/pangomm_1_4-2.46.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd0ab38c4372a12282ab46bf51016f040070c5cf866a0936f04058ba35f7656cb',
     armv7l: 'd0ab38c4372a12282ab46bf51016f040070c5cf866a0936f04058ba35f7656cb',
       i686: '65f4880d875dafa601622537ca47530dee764d293510f7871a11137d6025ccf0',
     x86_64: '50dd9b642fcc0dfa348f89e364d6db1a1f509e97aa0aee75e0b3be3cf7c14913'
  })

  depends_on 'cairomm_1_0' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'glibmm_2_4' # R
  depends_on 'glib' # R
  depends_on 'graphite' => :build
  depends_on 'libsigcplusplus' # R
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
