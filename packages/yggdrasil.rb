require 'package'

class Yggdrasil < Package
  description 'Overlay network implementation of a new routing scheme for mesh networks.'
  homepage 'https://yggdrasil-network.github.io/'
  version '0.5.13'
  license 'LGPLv3'
  compatibility 'all'
  source_url 'https://github.com/yggdrasil-network/yggdrasil-go.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ce7074d563bbe25a61582df619e4ffdf4591263ef0efc85fcd077dd626e272e7',
     armv7l: 'ce7074d563bbe25a61582df619e4ffdf4591263ef0efc85fcd077dd626e272e7',
       i686: '7e9ea0a875ab4b164f3e2a2aa1196611dc5a54fb519d941282113bae4ac7f60b',
     x86_64: 'b97775ddc46eb1417099d8c8893ad4f0c4456f606ae016f1875d410d2d7f47d1'
  })

  depends_on 'glibc' => :library
  depends_on 'go' => :build

  def self.patch
    # For some reason the version is not returned; hence this patch.
    system "sed -i 's,return \"unknown\",return \"#{version}\",' src/version/version.go"
  end

  def self.build
    system './build'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install %w[yggdrasil yggdrasilctl], "#{CREW_DEST_PREFIX}/bin", mode: 0o755
  end
end
