require 'package'

class Glibmm_2_4 < Package
  description 'C++ bindings for GLib'
  homepage 'https://www.gtkmm.org'
  @_ver = '2.66.5'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glibmm.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibmm_2_4/2.66.5_armv7l/glibmm_2_4-2.66.5-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibmm_2_4/2.66.5_armv7l/glibmm_2_4-2.66.5-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibmm_2_4/2.66.5_i686/glibmm_2_4-2.66.5-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibmm_2_4/2.66.5_x86_64/glibmm_2_4-2.66.5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3e34ada67361ef49fa5ef6849d86864834f24637492360412645a4f556f8b3d0',
     armv7l: '3e34ada67361ef49fa5ef6849d86864834f24637492360412645a4f556f8b3d0',
       i686: 'f272fb88a74508d78f0dfad36a3d39e870962ded2ecc404e3c85175efe6fef62',
     x86_64: 'b259f25b53e787d82690c55235c0180c264e7fcdf50d2e2be9aaf0cabf4f9bf5'
  })

  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'libsigcplusplus'
  depends_on 'libsigcplusplus' # R
  depends_on 'mm_common' => :build

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Dbuild-documentation=false \
    builddir"
    system 'meson configure builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
