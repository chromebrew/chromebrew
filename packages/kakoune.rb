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
    aarch64: 'ecd4b93d1306456a5a927a592d986642c07623584432123f19bdd8784aa56708',
     armv7l: 'ecd4b93d1306456a5a927a592d986642c07623584432123f19bdd8784aa56708',
       i686: '9ec9e9a3d7c7b6cbfeb16e3ab74edb2c743cd86a4a0bb239561b8276bd42ddf0',
     x86_64: 'f881c357f29625e75338cd0ebfc7eba135b88dedbd33be6e8618b6179b03c05c'
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
