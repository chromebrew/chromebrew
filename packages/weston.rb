require 'package'

class Weston < Package
  description 'Weston is the reference implementation of a Wayland compositor, and a useful compositor in its own right.'
  homepage 'http://wayland.freedesktop.org'
  version '4.0.0'
  compatibility 'i686,x86_64'
  case ARCH
  when 'i686', 'x86_64'
    source_url 'https://github.com/wayland-project/weston/archive/4.0.0.tar.gz'
    source_sha256 '46b0178cd37b0bf7471c9af12c847c7b8728699ecd5c04ce79be77ea12c98512'
    depends_on 'harfbuzz'
    depends_on 'libxcursor'
    depends_on 'libinput'
    depends_on 'libxkbcommon'
    depends_on 'wayland_protocols'
    depends_on 'libjpeg'
    depends_on 'libunwind'
    depends_on 'pango'
    depends_on 'dbus'
    depends_on 'libxxf86vm'
  end

  binary_url ({
      i686: 'https://dl.bintray.com/chromebrew/chromebrew/weston-4.0.0-chromeos-i686.tar.xz',
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/weston-4.0.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
      i686: '477a86049694ee6021a2cf98aa8d85acec4684fdee07c6f2508babd470d594f2',
    x86_64: '758ecfd17e47436b7c219676f5959379ed6a1ea7838abeeb82c54be456a47aa7',
  })

  def self.build
    system './autogen.sh'
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-weston-launch',
           '--enable-demo-clients-install'
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end

