require 'package'

class Glibmm_2_68 < Package
  description 'C++ bindings for GLib api version 2.68'
  homepage 'https://www.gtkmm.org'
  @_ver = '2.75.0'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glibmm.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibmm_2_68/2.75.0_armv7l/glibmm_2_68-2.75.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibmm_2_68/2.75.0_armv7l/glibmm_2_68-2.75.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibmm_2_68/2.75.0_i686/glibmm_2_68-2.75.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibmm_2_68/2.75.0_x86_64/glibmm_2_68-2.75.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6e6dea95b0de055316df3584217217ac6e71f1433f5fd94ce686a556e1f7cdcd',
     armv7l: '6e6dea95b0de055316df3584217217ac6e71f1433f5fd94ce686a556e1f7cdcd',
       i686: '2d8765e47873841ff2dd2dfa5b23dc8a7add20624978698223416e1e3e368860',
     x86_64: 'a50f35cdfec10d52ce52c8054310aca215bb2089da825245992672a1a12dec66'
  })

  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'libsigcplusplus3' # R
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
