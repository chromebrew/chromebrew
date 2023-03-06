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
       i686: 'file:///usr/local/tmp/packages/pangomm_1_4-2.46.3-chromeos-i686.tar.zst',
     x86_64: 'file:///usr/local/tmp/packages/pangomm_1_4-2.46.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
       i686: '1b2d1f408399784382577c632c7d8840102c5b462a5458410b1bb6d028644b0c',
     x86_64: 'af30b91e184de0bc84d648b484411dc7b969bf401e108a6d6b5aca33af0ae78c'
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
