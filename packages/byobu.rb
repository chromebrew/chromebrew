require 'buildsystems/autotools'

class Byobu < Autotools
  description 'Byobu is a GPLv3 open source text-based window manager and terminal multiplexer.'
  homepage 'https://www.byobu.org'
  version '6.15'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/dustinkirkland/byobu.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '97eafb4aa8bac875f896b214e64d1dbaad8b4d9e8228cfca6b2d264dc149905a',
     armv7l: '97eafb4aa8bac875f896b214e64d1dbaad8b4d9e8228cfca6b2d264dc149905a',
       i686: 'e9227845d0be7dadaa44827c23c21214ff425fa71190dfb5d43df47ec94d45f1',
     x86_64: 'a8b9c67d2a1b065d5f65203ba3a060e398c5648d3c25f63bddef602d586943dc'
  })

  depends_on 'tmux' unless File.exist? "#{CREW_PREFIX}/bin/screen"

  def self.patch
    system "sed -i '318,328d' ./usr/lib/byobu/include/shutil"
    system "sed -i '34,36d' ./usr/lib/byobu/release"
  end
end
