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
    aarch64: 'f68c551231c53e0abdf45f0999443aa3ef3f5eb6bbfe017496234f1e3d55efa2',
     armv7l: 'f68c551231c53e0abdf45f0999443aa3ef3f5eb6bbfe017496234f1e3d55efa2',
       i686: 'ed3a6f6a6c6f3a692c5da3327c7ba7c66069319af92dca537ac9697534fcad4e',
     x86_64: 'faf8443a8d69ca40d5b2be18243af2244d498e0b79b39b6bd8d5e90632ae38a1'
  })

  depends_on 'gcc_lib' # R
  depends_on 'gettext' => :build
  depends_on 'glibc' # R
  depends_on 'glib' # R
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
