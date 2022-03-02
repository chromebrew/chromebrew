require 'package'

class Libglvnd < Package
  description 'The GL Vendor-Neutral Dispatch library'
  homepage 'https://gitlab.freedesktop.org/glvnd/libglvnd'
  version '1.4.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/glvnd/libglvnd.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libglvnd/1.4.0_armv7l/libglvnd-1.4.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libglvnd/1.4.0_armv7l/libglvnd-1.4.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libglvnd/1.4.0_i686/libglvnd-1.4.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libglvnd/1.4.0_x86_64/libglvnd-1.4.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9f38d8734bbcd7e2258edf3a8e872093d10e71a5bcae250b211798413d2c617b',
     armv7l: '9f38d8734bbcd7e2258edf3a8e872093d10e71a5bcae250b211798413d2c617b',
       i686: '5e293d8f35f240ea212d1df3ca0fc852f60ac0fc79eb18d38489da7231022ac0',
     x86_64: 'f17ee5a381d022cdc3ad36601ba4d2df0550b51a540e81c9c0486b61fca014bd'
  })

  depends_on 'libxext'
  depends_on 'libx11'
  depends_on 'glproto'
  depends_on 'python3' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
