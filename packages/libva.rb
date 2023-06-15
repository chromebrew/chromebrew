require 'package'

class Libva < Package
  description 'Libva is an implementation for VA-API (Video Acceleration API)'
  homepage 'https://01.org/linuxmedia'
  version '2.17.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/intel/libva.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libva/2.17.0_armv7l/libva-2.17.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libva/2.17.0_armv7l/libva-2.17.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libva/2.17.0_i686/libva-2.17.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libva/2.17.0_x86_64/libva-2.17.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '07f809c623bffb4d16013374a9dbe6ad68e16c25026ec9b48aa447205ce4165d',
     armv7l: '07f809c623bffb4d16013374a9dbe6ad68e16c25026ec9b48aa447205ce4165d',
       i686: 'ef1f0b3f5afe4b99bd40cb664ed850194598be5a1501883ff6291c430b54ee90',
     x86_64: 'ca1bbccb041e31b567d4c1322e35afa8856d392b0408599c56778545c74ca42a'
  })

  depends_on 'glibc' # R
  depends_on 'libdrm' # R
  depends_on 'libglvnd' # R
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'mesa'
  depends_on 'wayland' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    --default-library=both \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.check
    system 'ninja -C builddir test'
  end
end
