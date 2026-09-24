require 'package'

class Keybase < Package
  description 'Keybase is encryption for everyone. Installs keybase cli'
  homepage 'https://keybase.io'
  version '6.6.3'
  license 'Apache-2.0, BSD, BSD-2, LGPL-3, MIT, MPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/keybase/client.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '651fe8afc45cb926d225fadf1d7973b266da4ed6044f025847930643c4692aec',
     armv7l: '651fe8afc45cb926d225fadf1d7973b266da4ed6044f025847930643c4692aec',
       i686: 'a84d66c4375aa92049c9718d077909e961cfd183f07d5e407b672455aead4482',
     x86_64: 'd91c91285cd5093706353a56fe8488a5b88eea39b70ee200859abbd0dda6feeb'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  def self.install
    system "go build -C go/keybase -o #{CREW_DEST_PREFIX}/bin/keybase"
  end
end
