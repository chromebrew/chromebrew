require 'buildsystems/meson'

class Shared_mime_info < Meson
  description 'The shared-mime-info package contains the core database of common types and the update-mime-database command used to extend it.'
  homepage 'https://freedesktop.org/wiki/Software/shared-mime-info/'
  version "2.5.1-#{CREW_ICU_VER}"
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xdg/shared-mime-info.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f44c8dcbed47cad416f9a85537672b76d4589afe17c200e86b689f533c934351',
     armv7l: 'f44c8dcbed47cad416f9a85537672b76d4589afe17c200e86b689f533c934351',
       i686: '7f27204235a196acd78790949c5ca13a4db2d9dac7b9f007135538baf3afeb73',
     x86_64: '3723dd862e10c39a982928773129aca53683c11571caf5360831ab7d2a5486d0'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'gettext' => :build
  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'libxml2' => :executable

  meson_options '-Dbuild-tests=false'

  def self.postinstall
    puts
    puts 'To update the database, execute the following:'.lightblue
    puts "update-mime-database #{CREW_PREFIX}/share/mime".lightblue
    puts
  end
end
