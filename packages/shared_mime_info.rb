require 'buildsystems/meson'

class Shared_mime_info < Meson
  description 'The shared-mime-info package contains the core database of common types and the update-mime-database command used to extend it.'
  homepage 'https://freedesktop.org/wiki/Software/shared-mime-info/'
  version "2.4-#{CREW_ICU_VER}-1"
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xdg/shared-mime-info.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7f3922b4fee143ae61619de98dec401e9958ecefbc5c96f0e26dadcc7b872811',
     armv7l: '7f3922b4fee143ae61619de98dec401e9958ecefbc5c96f0e26dadcc7b872811',
       i686: 'e6a71391c0ccfeae8d8c77fe7c966e8f1320d74ff0d97a842e57938f4f851154',
     x86_64: '13d8b12fa4f58e8d5e72ce872388b359637517bba20c766f8b12a97f42c75f51'
  })

  depends_on 'gcc_lib' # R
  depends_on 'gettext' => :build
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'libxml2' # R

  meson_options '-Dbuild-tests=false'

  def self.postinstall
    puts
    puts 'To update the database, execute the following:'.lightblue
    puts "update-mime-database #{CREW_PREFIX}/share/mime".lightblue
    puts
  end
end
