require 'buildsystems/meson'

class Baobab < Meson
  description 'Disk Usage Analyzer (also known as baobab) scans folders, devices or remote locations and and reports on the disk space consumed by each element.'
  homepage 'https://wiki.gnome.org/Apps/DiskUsageAnalyzer'
  version '49.1'
  license 'GPL-2+ and FDL-1.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/baobab.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8ec019f195cf97b40c0aa76b98439873b94b3efbd0cbf42faa0429113d599828',
     armv7l: '8ec019f195cf97b40c0aa76b98439873b94b3efbd0cbf42faa0429113d599828',
     x86_64: '36a249ef46164f7a3455d424f1b4ba037aa1b060d4b1499c58d69de54a4cbb50'
  })

  depends_on 'cairo' # R
  depends_on 'desktop_file_utils' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'graphene' # R
  depends_on 'gsettings_desktop_schemas' => :build
  depends_on 'gtk4' # R
  depends_on 'harfbuzz' # R
  depends_on 'libadwaita' # R
  depends_on 'pango' # R
  depends_on 'py3_itstool' => :build
  depends_on 'vala' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :build

  gnome
end
