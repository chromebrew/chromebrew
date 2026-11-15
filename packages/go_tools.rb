require 'package'

class Go_tools < Package
  description 'Developer tools for the Go programming language'
  homepage 'https://github.com/golang/tools'
  version '0.52.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/golang/tools.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0141ec69c68b626a09930977d0579eaaf1d38ffb56000c44c5c0e69f4dcce6f8',
     armv7l: '0141ec69c68b626a09930977d0579eaaf1d38ffb56000c44c5c0e69f4dcce6f8',
       i686: '4443ceb77c72d12b45d8448df64931adb83ed9711a59c72ec206edd012251453',
     x86_64: 'e652da1bf52b172a484378d15b258858398e97986b8a307eba99d63fabd5dde5'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install ./cmd..."
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/bundle", "#{CREW_DEST_PREFIX}/bin/go_bundle"
  end
end
