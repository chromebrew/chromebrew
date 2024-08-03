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
    aarch64: 'ca0a0b75e5eede5016d9252b8add9a6b39ce36120967d77ef29e3e72d0b0f37f',
     armv7l: 'ca0a0b75e5eede5016d9252b8add9a6b39ce36120967d77ef29e3e72d0b0f37f',
       i686: '153d0418a1ffe7d2290925caf9eb72dabd2405b9e99963af3573f1431cf1d842',
     x86_64: '58a918496fbae5794851ed7910ce0b5489c7d3753736e5f0f3e581190d0f1209'
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
