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
    aarch64: '42da3000e8d0a049524ef6d1ff8301e8863ca4de85cb8bb559f8a7223468661f',
     armv7l: '42da3000e8d0a049524ef6d1ff8301e8863ca4de85cb8bb559f8a7223468661f',
     x86_64: '44a9de4d6996f24774035b5d534f9ac589b2c609be7eb89d4b1dd090f069c0a9'
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
