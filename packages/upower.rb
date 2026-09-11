require 'buildsystems/meson'

class Upower < Meson
  description 'Abstraction for enumerating power devices, listening to device events and querying history and statistics'
  homepage 'https://upower.freedesktop.org'
  version '1.91.4'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/upower/upower.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0e91dd25aabb541a03c4d6ac532655ed6ad3bc7b02f7b2ef17a0e98c3f7bdb60',
     armv7l: '0e91dd25aabb541a03c4d6ac532655ed6ad3bc7b02f7b2ef17a0e98c3f7bdb60',
     x86_64: 'c8866def1793bfba679129f733eb4d8b440b28875884c7331f05dd6ace0deb85'
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
