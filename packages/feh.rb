require 'package'

class Feh < Package
  description 'feh is an X11 image viewer aimed mostly at console users.'
  homepage 'https://feh.finalrewind.org/'
  version '3.6.3'
  license 'feh'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://feh.finalrewind.org/feh-#{version}.tar.bz2"
  source_sha256 '437420f37f11614e008d066e2a3bdefcfc78144c8212998b2bacdd5d21ea23b4'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '396e94fde7cc62de565076329fc8e197daa257e15e8804dcc24d602d6399f07c',
     armv7l: '396e94fde7cc62de565076329fc8e197daa257e15e8804dcc24d602d6399f07c',
     x86_64: '5cc0e413b32dadd731173e3dd3aabbc97788cd27903f1b4d5f8c61cb8b181356'
  })

  depends_on 'gtk3'
  depends_on 'imlib2'
  depends_on 'libexif'
  depends_on 'libpng'
  depends_on 'libx11'
  depends_on 'libxinerama'
  depends_on 'sommelier'

  def self.build
    system "sed -i 's,gtk-update-icon-cache,gtk-update-icon-cache -t,g' Makefile"
    system 'make'
  end

  def self.install
    system "env CFLAGS='-flto=auto -fuse-ld=gold' \
      CXXFLAGS='-pipe -flto=auto -fuse-ld=gold' \
      LDFLAGS='-flto=auto' exif=1 \
      make \
      PREFIX=#{CREW_PREFIX}"
    system "make ICON_PREFIX=#{CREW_DEST_PREFIX}/share/icons \
      PREFIX=#{CREW_PREFIX} \
      DESTDIR=#{CREW_DEST_DIR} \
      install app=1"
  end
end
