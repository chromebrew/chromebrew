require 'package'

class Mp3cat < Package
  description 'A command line utility for joining MP3 files.'
  homepage 'https://www.dmulholl.com/dev/mp3cat.html'
  version '4.2.2'
  license 'Public domain'
  compatibility 'all'
  source_url 'https://github.com/dmulholl/mp3cat.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aaec98bd300b98172ec9d55136179fdff99bf267c5544d572b762ff6bd2e79bd',
     armv7l: 'aaec98bd300b98172ec9d55136179fdff99bf267c5544d572b762ff6bd2e79bd',
       i686: 'd998ee175531335ee0d5b3b76b6d9658d753a7983675cf46867d2fc4321f3d5d',
     x86_64: 'ba456930bc94cd13952f6769a55bd4ec4514a78bab5e105dd1625d70429ed95d'
  })

  depends_on 'glibc' # R
  depends_on 'go' => :build

  def self.build
    system 'go build -o bin/mp3cat'
  end

  def self.install
    FileUtils.install 'bin/mp3cat', "#{CREW_DEST_PREFIX}/bin/mp3cat", mode: 0o755
  end
end
