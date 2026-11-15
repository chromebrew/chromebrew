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
    aarch64: '24afe56e4d97ded4d9d4e6725c201d9dc5f40e33cc231376c7f473aa895c40b2',
     armv7l: '24afe56e4d97ded4d9d4e6725c201d9dc5f40e33cc231376c7f473aa895c40b2',
       i686: '93c1a83ad2f0041788f36c7ebd7e298bbdc9299846d3a9c67a71c4de14413d69',
     x86_64: '3d7cc947d02e3462f8cf8ac706449b33d2dad8f544a2a49c6c9ff5fd15b510d1'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'gettext' => :build
  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libxml2' => :executable
  depends_on 'xmlto' => :build

  meson_options '-Dbuild-tests=false'

  def self.postinstall
    puts
    puts 'To update the database, execute the following:'.lightblue
    puts "update-mime-database #{CREW_PREFIX}/share/mime".lightblue
    puts
  end
end
