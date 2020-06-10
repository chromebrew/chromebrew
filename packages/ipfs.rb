require 'package'

class Ipfs < Package
  description 'A peer-to-peer hypermedia protocol'
  homepage 'https://ipfs.io'
  version '0.4.13'
  compatibility 'all'
  source_url 'https://github.com/ipfs/go-ipfs/archive/v0.4.13.tar.gz'
  source_sha256 '9d5f2ef17a8bd4040fb4246c694034ec0ff323bc07d3f1469ce0877892695f31'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ipfs-0.4.13-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ipfs-0.4.13-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ipfs-0.4.13-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ipfs-0.4.13-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'eaefd30775098871ac00669290ffa13ecf8885fb9034801855b28c0e43ea9f0a',
     armv7l: 'eaefd30775098871ac00669290ffa13ecf8885fb9034801855b28c0e43ea9f0a',
       i686: '4fc25d3e9d9d552963de88959d55ba0de84bdf553d035e466fd330d1861409c2',
     x86_64: 'b85e2441356ad171dd9ca0c23a7619fb7bd45086710d230aa7049d85fcae047a',
  })

  depends_on 'go' => :build
  depends_on 'fuse'

  def self.build
    system 'mkdir -p ../src/github.com/ipfs/go-ipfs'
    system 'cp -aT . ../src/github.com/ipfs/go-ipfs/'
    system 'mv ../src .'
    system 'export GOPATH=`pwd`; cd src/github.com/ipfs/go-ipfs; make build'
  end

  def self.install
    Dir.chdir 'src/github.com/ipfs/go-ipfs' do
      system "install -D -m 00755 cmd/ipfs/ipfs #{CREW_DEST_PREFIX}/bin/ipfs"
    end
  end
end
