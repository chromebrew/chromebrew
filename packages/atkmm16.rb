require 'package'

class Atkmm16 < Package
  description 'Atkmm is the official C++ interface for the ATK accessibility toolkit library.'
  homepage 'https://www.gtkmm.org/'
  version '2.28.3'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/atkmm.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/atkmm16/2.28.3_armv7l/atkmm16-2.28.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/atkmm16/2.28.3_armv7l/atkmm16-2.28.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/atkmm16/2.28.3_i686/atkmm16-2.28.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/atkmm16/2.28.3_x86_64/atkmm16-2.28.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6f6bdd8bceb5b59604f8fc5ecff550c67ce2c05ead5a631ff0c08f1bca49a756',
     armv7l: '6f6bdd8bceb5b59604f8fc5ecff550c67ce2c05ead5a631ff0c08f1bca49a756',
       i686: '2cea07cda3cc93b7cadf9e459f1f65de60342bc837ca188ff9f520b7a3a3cca4',
     x86_64: 'c8330f03414564ade76af89936973b7667cf4a1c56ff2f5ae61024b4e1d3d731'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glibmm_2_4' # R
  depends_on 'glib' # R
  depends_on 'libsigcplusplus' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Dbuild-documentation=false \
    builddir"
    system 'meson configure --no-pager builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
