require 'package'

class Git_lfs < Package
  description 'Git extension for versioning large files'
  homepage 'https://git-lfs.com/'
  version '3.8.0'
  license 'AGPL-3'
  compatibility 'all'
  source_url "https://github.com/git-lfs/git-lfs/releases/download/v#{version}/git-lfs-v#{version}.tar.gz"
  source_sha256 '4f75492c6832038fa73d39a45316657208bb6caa23b273451cb4ec2358d42ccb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '06585f8acf12962daa1e25793d7243c003081b47c4858394acf082cc4e707860',
     armv7l: '06585f8acf12962daa1e25793d7243c003081b47c4858394acf082cc4e707860',
       i686: 'b9746b3065c76c902c75ec64f4f1ea0d824f6166220e08a58c5f17b553981bb1',
     x86_64: '1d4da286c38facef3a30b35eb29a3be732c0123cc5086258620aa048d8a4337b'
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
