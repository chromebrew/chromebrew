require 'package'

class Zola < Package
  description 'A fast static site generator'
  homepage 'https://www.getzola.org/'
  version '0.23.1'
  license 'MIT'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url "https://github.com/getzola/zola/releases/download/v#{version}/zola-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
  source_sha256 '5660d2848a4a294422f16687c9949c0b689bc5ebd236a649c75bb4c91e159c89'

  no_compile_needed

  def self.install
    FileUtils.install 'zola', "#{CREW_DEST_PREFIX}/bin/zola", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'zola' to get started.\n"
  end
end
