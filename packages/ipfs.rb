require 'package'

class Ipfs < Package
  description 'A peer-to-peer hypermedia protocol'
  homepage 'https://ipfs.io'
  version '0.4.13'
  license 'MIT and Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/ipfs/go-ipfs/archive/v0.4.13.tar.gz'
  source_sha256 '9d5f2ef17a8bd4040fb4246c694034ec0ff323bc07d3f1469ce0877892695f31'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ipfs/0.4.13_armv7l/ipfs-0.4.13-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ipfs/0.4.13_armv7l/ipfs-0.4.13-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ipfs/0.4.13_i686/ipfs-0.4.13-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ipfs/0.4.13_x86_64/ipfs-0.4.13-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'eaefd30775098871ac00669290ffa13ecf8885fb9034801855b28c0e43ea9f0a',
     armv7l: 'eaefd30775098871ac00669290ffa13ecf8885fb9034801855b28c0e43ea9f0a',
       i686: '4fc25d3e9d9d552963de88959d55ba0de84bdf553d035e466fd330d1861409c2',
     x86_64: 'b85e2441356ad171dd9ca0c23a7619fb7bd45086710d230aa7049d85fcae047a'
  })

  depends_on 'go' => :build
  depends_on 'fuse3'

  def self.build
    system 'mkdir -p ../src/github.com/ipfs/go-ipfs'
    system 'cp -aT . ../src/github.com/ipfs/go-ipfs/'
    system 'mv ../src .'
    system "GOPATH=#{Dir.pwd} make build", chdir: 'src/github.com/ipfs/go-ipfs'
  end

  def self.install
    Dir.chdir 'src/github.com/ipfs/go-ipfs' do
      system "install -D -m 00755 cmd/ipfs/ipfs #{CREW_DEST_PREFIX}/bin/ipfs"
    end
  end
end
