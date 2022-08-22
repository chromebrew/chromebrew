require 'package'

class Gdrive < Package
  description 'Google Drive CLI Client'
  homepage 'https://www.google.com/drive/'
  version '2.1.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/prasmussen/gdrive/releases/download/2.1.1/gdrive_2.1.1_linux_arm.tar.gz',
     armv7l: 'https://github.com/prasmussen/gdrive/releases/download/2.1.1/gdrive_2.1.1_linux_arm.tar.gz',
       i686: 'https://github.com/prasmussen/gdrive/releases/download/2.1.1/gdrive_2.1.1_linux_386.tar.gz',
     x86_64: 'https://github.com/prasmussen/gdrive/releases/download/2.1.1/gdrive_2.1.1_linux_amd64.tar.gz'
  })
  source_sha256({
    aarch64: '5e5229158dcf27c1dbd881b76fd6a0314106f1f35a8b374df33a34bb477261b5',
     armv7l: '5e5229158dcf27c1dbd881b76fd6a0314106f1f35a8b374df33a34bb477261b5',
       i686: 'de770d91e528a36d816d5617dd9593922e2c2b154a175fd1e89f196ea0381191',
     x86_64: '4c604e4af53723f3f8b5fb9c21a666244bd2a6cb1b2b6da26267b0dfad93fc78'
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'gdrive', "#{CREW_DEST_PREFIX}/bin/gdrive", mode: 0o755
  end
end
