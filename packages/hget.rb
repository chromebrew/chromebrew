require 'package'

class Hget < Package
  description 'Interruptable, resumable download accelerator'
  homepage 'https://github.com/huydx/hget'
  version '8cff5f7'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '5cd8050d079a49c9377a8e2ea91f90ab038a248ab2bf22a93a9fbab5689d1e96',
     armv7l: '5cd8050d079a49c9377a8e2ea91f90ab038a248ab2bf22a93a9fbab5689d1e96',
       i686: 'ba7f70141549d8d61be4dea806b34a36a895e06e8fb60c76caed3d3af937277f',
     x86_64: '0dd19e6e75f73830d19f699fbb2a83145465e77ae03323d59346ddc7be543faf'
  })

  depends_on 'go' => :build

  def self.install
    ENV['GOPATH'] = "#{Dir.pwd}/go"
    FileUtils.mkdir_p "#{Dir.pwd}/go/src"
    system 'go get -d github.com/huydx/hget'
    FileUtils.cd 'go/src/github.com/huydx/hget' do
      system 'make', 'clean', 'install'
      system "install -Dm755 bin/hget #{CREW_DEST_PREFIX}/bin/hget"
    end
  end
end
