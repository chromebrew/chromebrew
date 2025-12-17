require 'package'

class Kakoune < Package
  description "mawww's experiment for a better code editor"
  homepage 'http://kakoune.org/'
  compatibility 'all'
  license 'Unlicense'
  version '2025.06.03'
  source_url 'https://github.com/mawww/kakoune.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a4304ec155e6c375c841451df07d60b19ed288b0abc9f99b46a6de52a2b40321',
     armv7l: 'a4304ec155e6c375c841451df07d60b19ed288b0abc9f99b46a6de52a2b40321',
       i686: 'd602be65796ba2ec9b13a105910225469e9ba0b73c32459169b1e8ea8784ce13',
     x86_64: 'daed7d68e53f1f2751dc6a9a59c3efaab0a89651ff690b2cb5ac8be02e4d95f1'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    system 'make && make man'
  end

  def self.install
    FileUtils.install 'src/kak', "#{CREW_DEST_PREFIX}/bin/kak", mode: 0o755
    FileUtils.install 'doc/kak.1', "#{CREW_DEST_MAN_PREFIX}/man1/kak.1", mode: 0o644
  end

  def self.postinstall
    ExitMessage.add "\nType 'kak' to get started.\n"
  end
end
