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
    aarch64: '00fbf9862398df0cceb4eff10c2e0400d6ccdf454577c469032e11eabbe7a27c',
     armv7l: '00fbf9862398df0cceb4eff10c2e0400d6ccdf454577c469032e11eabbe7a27c',
       i686: '0ded55d937e53446cd6bd850d2b489f4580bae92434deb73fc01675a61293a17',
     x86_64: 'd88e9a4ea801e210ff75bf2f64de5a50138ce770c8faff979be2495d43e561f4'
  })

  depends_on 'gcc_lib' # R
  depends_on 'gettext' => :build
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'icu4c' # R
  depends_on 'libxml2' # R
  depends_on 'xmlto' => :build

  meson_options '-Dbuild-tests=false'

  def self.postinstall
    puts
    puts 'To update the database, execute the following:'.lightblue
    puts "update-mime-database #{CREW_PREFIX}/share/mime".lightblue
    puts
  end
end
