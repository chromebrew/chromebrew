require 'buildsystems/meson'

class Flatseal < Meson
  description 'Flatseal is a graphical utility to review and modify permissions from your Flatpak applications.'
  homepage 'https://github.com/tchx84/Flatseal/'
  version '2.4.1'
  license 'GPL-3+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/tchx84/Flatseal.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'afb8403d2d7aac8ac4c418f69984d2539b7bb7ac2275e90355d5241ba5595757',
     armv7l: 'afb8403d2d7aac8ac4c418f69984d2539b7bb7ac2275e90355d5241ba5595757',
     x86_64: '7e54828c6e3ce114abfce82b7765d2c5bdfb8c6dbbe949e35933860fb959c686'
  })

  depends_on 'desktop_file_utils'
  depends_on 'gjs'
  depends_on 'gtk4'
  depends_on 'libadwaita'
  depends_on 'sommelier' => :logical
  depends_on 'webkitgtk_6'

  run_tests
  meson_install_extras do
    FileUtils.symlink 'com.github.tchx84.Flatseal', "#{CREW_DEST_PREFIX}/bin/flatseal"
  end
end
