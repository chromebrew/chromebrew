require 'buildsystems/meson'

class Baobab < Meson
  description 'Disk Usage Analyzer (also known as baobab) scans folders, devices or remote locations and and reports on the disk space consumed by each element.'
  homepage 'https://wiki.gnome.org/Apps/DiskUsageAnalyzer'
  version '48.0'
  license 'GPL-2+ and FDL-1.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/baobab.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3213cb0a075400bc58005227e27095d450d335b40c1706671c8360ed5b61b80d',
     armv7l: '3213cb0a075400bc58005227e27095d450d335b40c1706671c8360ed5b61b80d',
     x86_64: 'f0a189907a995797fc453fcbe36b853576f50e5aaa7aec9d6bc4cf8ed6e02be4'
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
