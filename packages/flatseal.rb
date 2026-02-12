require 'buildsystems/meson'

class Flatseal < Meson
  description 'Flatseal is a graphical utility to review and modify permissions from your Flatpak applications.'
  homepage 'https://github.com/tchx84/Flatseal/'
  version '2.4.0'
  license 'GPL-3+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/tchx84/Flatseal.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd7f3ba5d78ae99465b7cee071dcb47f7b14337800367cf70caaa27114a3edbcc',
     armv7l: 'd7f3ba5d78ae99465b7cee071dcb47f7b14337800367cf70caaa27114a3edbcc',
     x86_64: '49b06ba914fbd127eba0c386ee75ed23a48a5f36bc8d679af711ad1938c8f810'
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
