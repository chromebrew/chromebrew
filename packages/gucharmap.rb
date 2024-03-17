require 'buildsystems/meson'
require_relative 'unicode_character_database'

class Gucharmap < Meson
  description 'GNOME Character Map, based on the Unicode Character Database.'
  homepage 'https://wiki.gnome.org/Apps/Gucharmap'
  version '15.1.3'
  license 'GPL-3+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gucharmap.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'be784ad5b741add6b1a8737ad6bedba3efb1e9e8e52096059da92e8097c684e2',
     armv7l: 'be784ad5b741add6b1a8737ad6bedba3efb1e9e8e52096059da92e8097c684e2',
     x86_64: '7079aa5b75e62232163b513c8825f988cd4b397a7e3d23aa687c3066377fd3e6'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'desktop_file_utilities' => :build
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'itstool' => :build
  depends_on 'pango' # R
  depends_on 'pcre2' # R
  depends_on 'vala' => :build

  gnome
  no_lto

  def self.prebuild
    downloader "https://www.unicode.org/Public/zipped/#{Unicode_character_database.version}/Unihan.zip", 'SKIP', '/tmp/Unihan.zip'
    downloader "https://www.unicode.org/Public/zipped/#{Unicode_character_database.version}/UCD.zip", 'SKIP', '/tmp/UCD.zip'
    Dir.chdir '/tmp' do
      system 'unzip UCD.zip'
    end
  end

  meson_options '-Ddocs=false -Ducd_path=/tmp/'
end
