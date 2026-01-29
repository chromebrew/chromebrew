require 'buildsystems/meson'

class Upower < Meson
  description 'Abstraction for enumerating power devices, listening to device events and querying history and statistics'
  homepage 'https://upower.freedesktop.org'
  version '1.91.0'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/upower/upower.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b9a1dde9bf2a8ea894a43137510656cbca93e8cd3f296bbf8a497a68208e1c52',
     armv7l: 'b9a1dde9bf2a8ea894a43137510656cbca93e8cd3f296bbf8a497a68208e1c52',
     x86_64: '9c9ecdacf4e8ea93869a2bacf6388d0fe63ec3fac5a2dbe8e8ac46e1f48162e5'
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
