require 'package'

class Pangomm_1_4 < Package
  description 'pangomm is the official C++ interface for the Pango font layout library.'
  homepage 'https://developer.gnome.org/pangomm/stable/'
  version '2.46.3'
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
    aarch64: 'aebb5450624f733edb35c4397445b2992996f29820e9d13880ce348ad38d1498',
     armv7l: 'aebb5450624f733edb35c4397445b2992996f29820e9d13880ce348ad38d1498',
       i686: '525c1b73617d88faf5df331af60ba13c93ad4da7bce9bdb849017dd57dbc5f0b',
     x86_64: 'bbad260e15756dcbb0f0faa65de5c95a3ab00ee8a41481d348db19cb842fe6ab'
  })

  depends_on 'cairomm_1_0' # R
  depends_on 'gcc_lib' # R
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
    system 'meson configure --no-pager builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
