require 'buildsystems/meson'

class Baobab < Meson
  description 'Disk Usage Analyzer (also known as baobab) scans folders, devices or remote locations and and reports on the disk space consumed by each element.'
  homepage 'https://wiki.gnome.org/Apps/DiskUsageAnalyzer'
  version '50.0'
  license 'GPL-2+ and FDL-1.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/baobab.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6a8ad182e6796c284b310c26ca8b020482acaa479c14d0c1b44d6152ad890527',
     armv7l: '6a8ad182e6796c284b310c26ca8b020482acaa479c14d0c1b44d6152ad890527',
     x86_64: '41736886f91cae79d09b80ed52b49741bef2a10f73124b4e59af7e7e471d5509'
  })

  depends_on 'cairo' => :executable
  depends_on 'desktop_file_utils' => :build
  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'graphene' => :executable
  depends_on 'gsettings_desktop_schemas' => :build
  depends_on 'gtk4' => :executable
  depends_on 'harfbuzz' => :executable
  depends_on 'libadwaita' => :executable
  depends_on 'pango' => :executable
  depends_on 'py3_itstool' => :build
  depends_on 'vala' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :build

  gnome
end
