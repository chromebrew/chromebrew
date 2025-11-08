require 'package'

class Ironclad < Package
  description 'A command line password manager.'
  homepage 'https://www.dmulholl.com/docs/ironclad/master/'
  version '2.7.0'
  license '0BSD'
  compatibility 'all'
  source_url 'https://github.com/dmulholl/ironclad.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd71c5253d76d64b58a2d32732745e658d66f0cc430dad5513e52910e8bde3b51',
     armv7l: 'd71c5253d76d64b58a2d32732745e658d66f0cc430dad5513e52910e8bde3b51',
       i686: '17e304fd45ac30488bd57856c50135da1638c2cb060da2401ed694db9d569d4d',
     x86_64: '764b3f9256a2ad15879341e7b1949d7b8b15a2524cc75ebb05310a6443fcc2e5'
  })

  depends_on 'glibc' # R
  depends_on 'go' => :build

  def self.build
    system 'make build'
  end

  def self.install
    FileUtils.install 'build/ironclad', "#{CREW_DEST_PREFIX}/bin/ironclad", mode: 0o755
  end
end
