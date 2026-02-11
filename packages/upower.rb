require 'buildsystems/meson'

class Upower < Meson
  description 'Abstraction for enumerating power devices, listening to device events and querying history and statistics'
  homepage 'https://upower.freedesktop.org'
  version '1.91.1'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/upower/upower.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c65de3ca0d706636915d1f7527639802d47aed45782190fc7668be080937c7d4',
     armv7l: 'c65de3ca0d706636915d1f7527639802d47aed45782190fc7668be080937c7d4',
     x86_64: 'b2500fc970ef04493caae44b3e9ece890f19bd44370f285aea94e6bbc413a5b2'
  })

  depends_on 'docbook_xml' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'libgudev' # R
  depends_on 'libusb' => :build
  depends_on 'libxslt' => :build
  depends_on 'py3_pygments' => :build

  meson_options "-Dos_backend=linux \
      -Dsystemdsystemunitdir=no \
      -Dhistorydir=#{CREW_PREFIX}/var \
      -Dudevrulesdir=#{CREW_PREFIX}/etc/udev \
      -Dudevhwdbdir=#{CREW_PREFIX}/etc/udev"
end
