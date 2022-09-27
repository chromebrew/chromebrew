require 'package'

class Glibmm_2_68 < Package
  description 'C++ bindings for GLib api version 2.68'
  homepage 'https://www.gtkmm.org'
  @_ver = '2.74.0'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "https://ftp.gnome.org/pub/GNOME/sources/glibmm/#{@_ver_prelastdot}/glibmm-#{@_ver}.tar.xz"
  source_sha256 '2b472696cbac79db8e405724118ec945219c5b9b18af63dc8cfb7f1d89b0f1fa'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibmm_2_68/2.74.0_armv7l/glibmm_2_68-2.74.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibmm_2_68/2.74.0_armv7l/glibmm_2_68-2.74.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibmm_2_68/2.74.0_i686/glibmm_2_68-2.74.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibmm_2_68/2.74.0_x86_64/glibmm_2_68-2.74.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b464088efb05c2cb1b403c1b60f4c17fb6bac1e522430175c0469d5cfc2f71a7',
     armv7l: 'b464088efb05c2cb1b403c1b60f4c17fb6bac1e522430175c0469d5cfc2f71a7',
       i686: '80f5820530d743a99b18df63652e797bcb85c4215e9b8a9e39074d6b63765530',
     x86_64: 'b9583ce77a34e5fa1138f47d25761eea9a06068d31caf6f8652f3d035f93b5ab'
  })

  depends_on 'libsigcplusplus3'
  depends_on 'mm_common' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    --default-library=both \
    -Dbuild-documentation=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
