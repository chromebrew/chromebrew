require 'buildsystems/meson'

class Shared_mime_info < Meson
  description 'The shared-mime-info package contains the core database of common types and the update-mime-database command used to extend it.'
  homepage 'https://freedesktop.org/wiki/Software/shared-mime-info/'
  version "2.4-#{CREW_ICU_VER}"
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xdg/shared-mime-info.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bfe13f241a7ed68d6dc8121d92c8d639dd7257cc4bc5880d63fc81ab380c4241',
     armv7l: 'bfe13f241a7ed68d6dc8121d92c8d639dd7257cc4bc5880d63fc81ab380c4241',
       i686: '37ab32faf04eb17cdb9c1e2c1bdfa38017eaaa5a620331c7487db72f3683bec6',
     x86_64: '670616572e7fb982ba18cbdab595638c359f978a03aaa560ae9b4118b818e9d3'
  })

  depends_on 'gcc_lib' # R
  depends_on 'gettext' => :build
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'icu4c' # R
  depends_on 'libxml2' # R
  depends_on 'xmlto' => :build

  def self.postinstall
    puts
    puts 'To update the database, execute the following:'.lightblue
    puts "update-mime-database #{CREW_PREFIX}/share/mime".lightblue
    puts
  end
end
