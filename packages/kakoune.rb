require 'package'

class Kakoune < Package
  description "mawww's experiment for a better code editor"
  homepage 'http://kakoune.org/'
  compatibility 'all'
  license 'Unlicense'
  version '2026.05.21'
  source_url 'https://github.com/mawww/kakoune.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '773d7445ac20723c427c093a4b91c90ea8e50a52a85e878b390eba811628f94f',
     armv7l: '773d7445ac20723c427c093a4b91c90ea8e50a52a85e878b390eba811628f94f',
       i686: '969000ef6c20f59a2499ff01620878ef6659ed0dfcfed9ff7c3dc9bf1c0b95d5',
     x86_64: 'a1e8fcaa359e2e5d06daf1379949c03eb9a13d1cc61c54a6ac1d9683e97fdb66'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

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
