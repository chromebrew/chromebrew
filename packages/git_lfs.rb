require 'package'

class Git_lfs < Package
  description 'Git extension for versioning large files'
  homepage 'https://git-lfs.com/'
  version '3.7.1'
  license 'AGPL-3'
  compatibility 'all'
  source_url "https://github.com/git-lfs/git-lfs/releases/download/v#{version}/git-lfs-v#{version}.tar.gz"
  source_sha256 '8f56058622edfea1d111e50e9844ef2f5ce670b2dbe4d55d48e765c943af4351'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '950c862d38542c4e111c29f196b57e3188bf0aba7e58ae5ae887e4058fb03cf9',
     armv7l: '950c862d38542c4e111c29f196b57e3188bf0aba7e58ae5ae887e4058fb03cf9',
       i686: 'b7ac2d1172b5381816f6f0ebc33c0772afa7a990e79b334868fb8d76f4d191bc',
     x86_64: 'c5c0a929e356957e01d77d61002ffad407dbc191d1167a71134418acfa979b7c'
  })

  depends_on 'asciidoctor' => :build
  depends_on 'glibc' # R
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
