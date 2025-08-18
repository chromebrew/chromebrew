require 'package'

class Libmbim < Package
  description 'libmbim is a glib-based library for talking to WWAN modems and devices which speak the Mobile Interface Broadband Model (MBIM) protocol.'
  homepage 'https://www.freedesktop.org/wiki/Software/libmbim/'
  version '1.32.0'
  license 'LGPL-2'
  compatibility 'all'
  source_url "https://www.freedesktop.org/software/libmbim/libmbim-#{version}.tar.xz"
  source_sha256 '74c56b6d4ae602dab6bf290bc85a556ee2abaee1ece250e0fd1699547415c483'
  binary_compression 'tar.zst'

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
      #{CREW_CONFIGURE_OPTIONS} \
      --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
