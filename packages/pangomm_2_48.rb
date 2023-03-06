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
       i686: 'file:///usr/local/tmp/packages/pangomm_2_48-2.50.1-chromeos-i686.tar.zst',
     x86_64: 'file:///usr/local/tmp/packages/pangomm_2_48-2.50.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
       i686: 'feadc00a4e309c193f0e5aaeda18e80dfaa8a2505e5c270f0044546f8908dcb5',
     x86_64: '7becb54e99d358f1306b0a1865b3893895d053cf380088e04ea4d77b3ccd49d2'
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
