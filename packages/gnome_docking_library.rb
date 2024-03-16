require 'buildsystems/autotools'

class Gnome_docking_library < Autotools
  description 'GUsb is a GObject wrapper for libusb1'
  homepage 'https://www.gnome.org/'
  version '3.40.0'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gdl.git'
  git_hashtag "GDL_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '666e943121c47a202f5de8800c00226b917dbbbe75d0ba8b9dacba68f0f9ad41',
     armv7l: '666e943121c47a202f5de8800c00226b917dbbbe75d0ba8b9dacba68f0f9ad41',
     x86_64: '94341d3b3ea28e34a48e0610996901a9c1905f98b7fa0063c0f4938b27c337ed'
  })

  depends_on 'gtk_doc' => :build
  depends_on 'gtk3' => :build
  depends_on 'libxml2' => :build
  depends_on 'gnome_common' => :build

  gnome
end
