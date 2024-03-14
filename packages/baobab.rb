require 'buildsystems/meson'

class Baobab < Meson
  description 'Disk Usage Analyzer (also known as baobab) scans folders, devices or remote locations and and reports on the disk space consumed by each element.'
  homepage 'https://wiki.gnome.org/Apps/DiskUsageAnalyzer'
  version '45.0'
  license 'GPL-2+ and FDL-1.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/baobab.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7405ce4a84ca2ffeab17643a9efa11ced62a1687ee3c8433215bda8f177b541f',
     armv7l: '7405ce4a84ca2ffeab17643a9efa11ced62a1687ee3c8433215bda8f177b541f',
     x86_64: '0e1c62920726909f86756309f9a1a2efc7a520eaa78c63d88678bdbd4ea11e67'
  })

  depends_on 'desktop_file_utils' => :build
  depends_on 'gtk3' => :build
  depends_on 'gsettings_desktop_schemas' => :build
  depends_on 'itstool' => :build
  depends_on 'vala' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :build
  depends_on 'glib' => :build
  depends_on 'glibc' => :build
  depends_on 'harfbuzz' => :build
  depends_on 'pango' => :build
  depends_on 'gtk4' => :build
  depends_on 'libadwaita' => :build
  depends_on 'cairo' # R
  depends_on 'harfbuzz' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk4' # R
  depends_on 'libadwaita' # R
  depends_on 'pango' # R

  gnome
end
