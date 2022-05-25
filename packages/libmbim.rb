require 'package'

class Libmbim < Package
  description 'libmbim is a glib-based library for talking to WWAN modems and devices which speak the Mobile Interface Broadband Model (MBIM) protocol.'
  homepage 'https://www.freedesktop.org/wiki/Software/libmbim/'
  version '1.24.6'
  license 'LGPL-2'
  compatibility 'all'
  source_url "https://www.freedesktop.org/software/libmbim/libmbim-#{version}.tar.xz"
  source_sha256 '760465caaa1ccd699c14290e9791da456d5300dd11ebf4c1486151033e875dfd'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmbim/1.24.6_armv7l/libmbim-1.24.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmbim/1.24.6_armv7l/libmbim-1.24.6-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmbim/1.24.6_i686/libmbim-1.24.6-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmbim/1.24.6_x86_64/libmbim-1.24.6-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'ffb063051859e2696af5f44b10de9915becb1c22cc90581b3962814be7626f0c',
     armv7l: 'ffb063051859e2696af5f44b10de9915becb1c22cc90581b3962814be7626f0c',
       i686: '82b1a84f2226675537c939ada353ec29e962ec53000946e91c2a14a599fe98a8',
     x86_64: '1e5b4926e3baf334425804688ee72c75e8cc9a6482102d9ef8bf727123561570'
  })

  depends_on 'glib'

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure \
      #{CREW_OPTIONS} \
      --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
