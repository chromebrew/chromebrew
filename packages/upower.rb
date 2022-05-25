require 'buildsystems/meson'

class Upower < Meson
  description 'Abstraction for enumerating power devices, listening to device events and querying history and statistics'
  homepage 'https://upower.freedesktop.org'
  version '1.90.2'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/upower/upower.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upower/1.90.2_armv7l/upower-1.90.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upower/1.90.2_armv7l/upower-1.90.2-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upower/1.90.2_x86_64/upower-1.90.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4b7a470ec75af657fd8ca4cac58f6adf568756348a7c1b4112c1521fefa3cbcf',
     armv7l: '4b7a470ec75af657fd8ca4cac58f6adf568756348a7c1b4112c1521fefa3cbcf',
     x86_64: 'cfe67815bc2225f8189e8f2b426b61258a081c6b4a3869e52c6e991bece42b72'
  })

  depends_on 'docbook_xsl' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'libgudev' # R
  depends_on 'libusb' => :build
  depends_on 'py3_pygments' => :build

  meson_options "-Dos_backend=linux \
      -Dsystemdsystemunitdir=no \
      -Dhistorydir=#{CREW_PREFIX}/var \
      -Dudevrulesdir=#{CREW_PREFIX}/etc/udev \
      -Dudevhwdbdir=#{CREW_PREFIX}/etc/udev"
end
