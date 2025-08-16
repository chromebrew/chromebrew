require 'buildsystems/meson'

class Upower < Meson
  description 'Abstraction for enumerating power devices, listening to device events and querying history and statistics'
  homepage 'https://upower.freedesktop.org'
  version '1.90.9'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/upower/upower.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bc09340bdb4e6878f628a44600605ae588b3740ddd649d4f7b2f1a5f25581b82',
     armv7l: 'bc09340bdb4e6878f628a44600605ae588b3740ddd649d4f7b2f1a5f25581b82',
     x86_64: '4e9693515224ebdb7d7064767b6c8c52050b6801e4599c7711c486c231108da0'
  })

  depends_on 'docbook_xsl' => :build
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
