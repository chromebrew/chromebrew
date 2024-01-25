require 'package'

class Libusbmuxd < Package
  description 'USB Multiplex Daemon'
  homepage 'http://www.libimobiledevice.org/'
  version '2.0.2'
  license 'GPL-2+ and LGPL-2.1+'
  compatibility 'all'
  source_url "https://github.com/libimobiledevice/libusbmuxd/archive/#{version}.tar.gz"
  source_sha256 '8ae3e1d9340177f8f3a785be276435869363de79f491d05d8a84a59efc8a8fdc'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '731ccae4db42bb38174653ebfebd73e70d9f21c3a14d4df9bc81310e9261294d',
     armv7l: '731ccae4db42bb38174653ebfebd73e70d9f21c3a14d4df9bc81310e9261294d',
       i686: '71bf097eefdce79c6e470211237db21a11f34656ca54500a792525c24c8d8935',
     x86_64: '022b15b6cacd910ff840003d147d9d7f702eee9a49b012dc2b18b8fb6414b985'
  })

  depends_on 'glib'
  depends_on 'libplist'

  def self.build
    system "env CFLAGS='-flto=auto' \
      CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./autogen.sh #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
