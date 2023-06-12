require 'package'

class Pangomm_2_48 < Package
  description 'pangomm is the official C++ interface for the Pango font layout library.'
  homepage 'https://developer.gnome.org/pangomm/stable/'
  version '2.50.1'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/pangomm.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pangomm_2_48/2.50.1_armv7l/pangomm_2_48-2.50.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pangomm_2_48/2.50.1_armv7l/pangomm_2_48-2.50.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pangomm_2_48/2.50.1_i686/pangomm_2_48-2.50.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pangomm_2_48/2.50.1_x86_64/pangomm_2_48-2.50.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '217a0cdd025020aefaa9c8a07366e72ac564d7d8fbdb3c45bfd4e29ae1c69204',
     armv7l: '217a0cdd025020aefaa9c8a07366e72ac564d7d8fbdb3c45bfd4e29ae1c69204',
       i686: '8a9b560961d6f11166fd47bfcefbecd11b0196f979e33433c321305dece1bb94',
     x86_64: '385ac710ce7ae48615305920bdb3c1284211799f9db312aaba9805232c40c02a'
  })

  depends_on 'cairomm_1_16' # R
  depends_on 'gcc_lib' # R
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
