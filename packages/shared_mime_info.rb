require 'buildsystems/meson'

class Shared_mime_info < Meson
  description 'The shared-mime-info package contains the core database of common types and the update-mime-database command used to extend it.'
  homepage 'https://freedesktop.org/wiki/Software/shared-mime-info/'
  version '2.4'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xdg/shared-mime-info.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '457f70c2f07f2cd69f271ae1725bb316d610ae2d795ba1360c7cab90ab655d31',
     armv7l: '457f70c2f07f2cd69f271ae1725bb316d610ae2d795ba1360c7cab90ab655d31',
       i686: '7dac326254618b28f4b9c9d324aa568919b2246e14fed40985fd5f7a452535e4',
     x86_64: '409a154e6913afae52b524b0d91ff8e6f0b5b71af4200324cccdba6c9b36f723'
  })

  depends_on 'gcc_lib' # R
  depends_on 'gettext' => :build
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'icu4c' # R
  depends_on 'libxml2_autotools' # R
  depends_on 'libxml2' # R
  depends_on 'xmlto' => :build

  def self.postinstall
    puts
    puts 'To update the database, execute the following:'.lightblue
    puts "update-mime-database #{CREW_PREFIX}/share/mime".lightblue
    puts
  end
end
