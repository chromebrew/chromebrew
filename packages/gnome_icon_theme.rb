require 'buildsystems/autotools'

class Gnome_icon_theme < Autotools
  description 'GNOME Icon Theme'
  homepage 'https://ftp.gnome.org/pub/GNOME/sources/gnome-icon-theme/'
  version '3.12.0-1'
  license 'LGPL-3 or CC-BY-SA-3.0'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/gnome-icon-theme/3.12/gnome-icon-theme-3.12.0.tar.xz'
  source_sha256 '359e720b9202d3aba8d477752c4cd11eced368182281d51ffd64c8572b4e503a'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'd30d85fac5dd8b3bede925be24dcbae08d6935f4a258e85715c93564225028a7',
     armv7l: 'd30d85fac5dd8b3bede925be24dcbae08d6935f4a258e85715c93564225028a7',
       i686: '4f3fd419e30d860013e77040c6a77c030b8a8cca4e693ad893dab08a8e5805bf',
     x86_64: '98e7ee87dd207e81663dca35d752f92808d64cb8ebeb6a815a6ad3a8c2402e27'
  })

  depends_on 'gtk2' => :build
  depends_on 'icon_naming_utils'

  gnome

  configure_options '--enable-icon-mapping'
end
