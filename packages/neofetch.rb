require 'package'

class Neofetch < Package
  description 'A fast, highly customizable system info script'
  homepage 'https://github.com/dylanaraps/neofetch'
  version '7.1.0-ccd5'
  license 'MIT-with-advertising'
  compatibility 'all'
  source_url 'https://github.com/dylanaraps/neofetch.git'
  git_hashtag 'ccd5d9f52609bbdcd5d8fa78c4fdb0f12954125f'

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "PREFIX=#{CREW_PREFIX}", 'install'
  end
end
