require 'package'

class Libportal < Package
  description 'libportal provides GIO-style async APIs for most Flatpak portals.'
  homepage 'https://github.com/flatpak/libportal'
  version '0.6-1'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/flatpak/libportal/archive/refs/tags/0.6.tar.gz'
  source_sha256 '8ad326c4f53b7433645dc86d994fef0292bee8adda0fe67db9288ace19250a9c'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libportal/0.6-1_armv7l/libportal-0.6-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libportal/0.6-1_armv7l/libportal-0.6-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libportal/0.6-1_i686/libportal-0.6-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libportal/0.6-1_x86_64/libportal-0.6-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e36d5b19b14145ca110f55da37402b3898677e01b86a3e77401f1687e280d00a',
     armv7l: 'e36d5b19b14145ca110f55da37402b3898677e01b86a3e77401f1687e280d00a',
       i686: 'dfda763649d95d880aa83a853203488afc6f423970f3707d26bf2c89456ff284',
     x86_64: 'ff87e704a0402c8aba6ddf27a5d3bc5e4289251cd2fc80478f70254ece4c37c4'
  })

  depends_on 'gobject_introspection'
  depends_on 'gtk4'
  depends_on 'gtk3'
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader'

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Dbackends=gtk3,gtk4 \
    -Ddocs=false \
    -Dportal-tests=false \
    -Dtests=false \
    builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
