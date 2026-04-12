require 'buildsystems/autotools'

class Byobu < Autotools
  description 'Byobu is a GPLv3 open source text-based window manager and terminal multiplexer.'
  homepage 'https://www.byobu.org'
  version '6.14'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/dustinkirkland/byobu.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1b48527b4d5942fabe2345c6c89b72b053e9294f74192102f558a8fdf44fdbd4',
     armv7l: '1b48527b4d5942fabe2345c6c89b72b053e9294f74192102f558a8fdf44fdbd4',
       i686: 'dc3b2d01268dd250fe9c76121aab4afea810a84219e2ec57272a81021ac87437',
     x86_64: '09722949ca77e1e6b9c25adc67254950fc557911a355bda739db160bbd44e850'
  })

  depends_on 'tmux' unless File.exist? "#{CREW_PREFIX}/bin/screen"

  def self.patch
    system "sed -i '318,328d' ./usr/lib/byobu/include/shutil"
    system "sed -i '34,36d' ./usr/lib/byobu/release"
  end
end
