require 'buildsystems/meson'

class Flatseal < Meson
  description 'Flatseal is a graphical utility to review and modify permissions from your Flatpak applications.'
  homepage 'https://github.com/tchx84/Flatseal/'
  version '2.2.0'
  license 'GPL-3+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/tchx84/Flatseal.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5d7085de32cad237c2242e87b72cd3078a1970db3cd7104a34e79a6dc48cdf8d',
     armv7l: '5d7085de32cad237c2242e87b72cd3078a1970db3cd7104a34e79a6dc48cdf8d',
     x86_64: '1a8e06bedd15890a450a38bfe7b1947ba8246c2bee3bd611e55856c45e5eafcf'
  })

  depends_on 'desktop_file_utils'
  depends_on 'gjs'
  depends_on 'gtk4'
  depends_on 'libadwaita'
  depends_on 'sommelier'
  depends_on 'webkitgtk_6'

  run_tests
  meson_install_extras do
    FileUtils.symlink 'com.github.tchx84.Flatseal', "#{CREW_DEST_PREFIX}/bin/flatseal"
  end
end
