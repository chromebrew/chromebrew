require 'buildsystems/meson'

class Upower < Meson
  description 'Abstraction for enumerating power devices, listening to device events and querying history and statistics'
  homepage 'https://upower.freedesktop.org'
  version '1.91.5'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/upower/upower.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6f85ea3fbd03e7e8bf848b234cc17285b22f126ab7373b5258fa8b219dddb559',
     armv7l: '6f85ea3fbd03e7e8bf848b234cc17285b22f126ab7373b5258fa8b219dddb559',
     x86_64: 'edf5e96736d1f38351c348275e844ca26eaa374085ef4a606c39fde93a7311e3'
  })

  depends_on 'docbook_xml' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'libgudev' => :executable
  depends_on 'libgudev' => :library
  depends_on 'libusb' => :build
  depends_on 'libxslt' => :build
  depends_on 'py3_pygments' => :build

  meson_options "-Dos_backend=linux \
      -Dsystemdsystemunitdir=no \
      -Dhistorydir=#{CREW_PREFIX}/var \
      -Dudevrulesdir=#{CREW_PREFIX}/etc/udev \
      -Dudevhwdbdir=#{CREW_PREFIX}/etc/udev"
end
