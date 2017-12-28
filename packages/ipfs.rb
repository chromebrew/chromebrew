require 'package'

class Ipfs < Package
  description 'A peer-to-peer hypermedia protocol'
  homepage 'https://ipfs.io'
  version '0.4.13'
  source_url 'https://github.com/ipfs/go-ipfs/archive/v0.4.13.tar.gz'
  source_sha256 '9d5f2ef17a8bd4040fb4246c694034ec0ff323bc07d3f1469ce0877892695f31'

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
