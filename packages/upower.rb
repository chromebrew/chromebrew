require 'package'

class Upower < Package
  description 'Abstraction for enumerating power devices, listening to device events and querying history and statistics'
  homepage 'https://upower.freedesktop.org'
  version '1.90.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/upower/upower/-/archive/v1.90.0/upower-v1.90.0.tar.bz2'
  source_sha256 'eafa0a367dc0417390984eeb81e9d1a2b449999ba6ad20ed39bf270d0b4e5e77'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upower/1.90.0_armv7l/upower-1.90.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upower/1.90.0_armv7l/upower-1.90.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upower/1.90.0_i686/upower-1.90.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upower/1.90.0_x86_64/upower-1.90.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2468840113835a829c7b94744958ff8fe11dcdbaa1dedafb5c924e91da4331cf',
     armv7l: '2468840113835a829c7b94744958ff8fe11dcdbaa1dedafb5c924e91da4331cf',
       i686: '302a4a5efeaecee4f0d01a45666ce0e049556b2f590f44af0631576842233622',
     x86_64: 'f289eb3beb36fbcf5dd26a57207b0b04062132d75e9a1feda7a50e86a801866f'
  })

  depends_on 'libusb'
  depends_on 'libgudev' # R
  depends_on 'docbook_xsl' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'py3_pygments' => :build
  depends_on 'gcc_lib' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      -Dos_backend=linux \
      -Dsystemdsystemunitdir=no \
      -Dhistorydir=#{CREW_PREFIX}/var \
      -Dudevrulesdir=#{CREW_PREFIX}/etc/udev \
      -Dudevhwdbdir=#{CREW_PREFIX}/etc/udev \
      builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
