require 'package'

class Git_lfs < Package
  description 'Git extension for versioning large files'
  homepage 'https://git-lfs.com/'
  version '3.8.1'
  license 'AGPL-3'
  compatibility 'all'
  source_url "https://github.com/git-lfs/git-lfs/releases/download/v#{version}/git-lfs-v#{version}.tar.gz"
  source_sha256 '1939307bef808580f7c8954ede7072889d7e76721f5d6fdc4ab110bf907330ab'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '61d03e9a62af9205cd0bcad7a9966e11bf7de9a8d9d5a89de737e6da9d42787c',
     armv7l: '61d03e9a62af9205cd0bcad7a9966e11bf7de9a8d9d5a89de737e6da9d42787c',
       i686: 'aae63aa8e3825c2ecad1f905b950f0e8f2eaa8b29a4d59f0982f28595e0b3d05',
     x86_64: '2c83d71219ae71e09710f3cad7a06bdcaba62c00ee3993f43743dea4839317ef'
  })

  depends_on 'asciidoctor' => :build
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  def self.build
    system 'go build -o bin/git-lfs'
    Dir['docs/man/*.adoc'].each do |adoc|
      system "asciidoctor --backend manpage #{adoc}"
    end
  end

  def self.install
    FileUtils.install 'bin/git-lfs', "#{CREW_DEST_PREFIX}/bin/git-lfs", mode: 0o755
    Dir['docs/man/*.1'].each do |manpage|
      man = File.basename(manpage)
      FileUtils.install manpage, "#{CREW_DEST_MAN_PREFIX}/man1/#{man}", mode: 0o644
    end
  end
end
