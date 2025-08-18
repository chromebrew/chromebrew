require 'buildsystems/autotools'

class Libxfce4ui < Autotools
  description 'Replacement of the old libxfcegui4 library'
  homepage 'https://xfce.org/'
  version '4.20.2'
  license 'LGPL-2+ and GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://archive.xfce.org/src/xfce/libxfce4ui/4.19/libxfce4ui-#{version}.tar.bz2"
  source_sha256 '7515bf959b73b956ceb967351c7e299cbb3668a53d35f9c770eb72e00d93ced6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f61f13d9006eef6b9f392de4e48c0d3639931c13baedfc76fc79524dd3c7fd57',
     armv7l: 'f61f13d9006eef6b9f392de4e48c0d3639931c13baedfc76fc79524dd3c7fd57',
     x86_64: '8d556af33dc6bb8c0ba938d2f62d31697c5727f10de56a68ea04c767aecc51b5'
  })

  depends_on 'gtk3'
  depends_on 'gtk2'
  depends_on 'pygtk' # For gtk+
  depends_on 'xfconf'

  run_tests
end
