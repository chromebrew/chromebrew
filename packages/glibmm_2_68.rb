require 'package'

class Glibmm_2_68 < Package
  description 'C++ bindings for GLib api version 2.68'
  homepage 'https://www.gtkmm.org'
  version '2.78.0'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/glibmm.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibmm_2_68/2.78.0_armv7l/glibmm_2_68-2.78.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibmm_2_68/2.78.0_armv7l/glibmm_2_68-2.78.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibmm_2_68/2.78.0_x86_64/glibmm_2_68-2.78.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd101b082fdbd28e16fed1ad66a3042a58f4d4d5575e5a5b9de59552ac8402964',
     armv7l: 'd101b082fdbd28e16fed1ad66a3042a58f4d4d5575e5a5b9de59552ac8402964',
     x86_64: '115a613e6a6f7dcc3faa0f4bbc5eecadb068951a3c9e1bf0a9f90102702db5a0'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'graphviz' # R
  depends_on 'libsigcplusplus3' # R
  depends_on 'mm_common' => :build

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
