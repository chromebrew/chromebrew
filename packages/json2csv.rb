require 'package'

class Json2csv < Package
  description 'command line tool to convert json to csv'
  homepage 'https://github.com/jehiah/json2csv'
  version '1.2.1'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e67418f6e6ea2ed05d6fbb5e74cf4db372ea27d6ab81dd61a4a9226d9bb53577',
     armv7l: 'e67418f6e6ea2ed05d6fbb5e74cf4db372ea27d6ab81dd61a4a9226d9bb53577',
       i686: '363a35b5d36b38900f9fbc09aaa1e36c7efcbdf62a0054fc560d4556a64e6a69',
     x86_64: 'b10d4622d48afd8f9efc9081ff786cb911995dd9d80893c51198979fa31eceaa'
  })

  depends_on 'glibc' # R
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/jehiah/json2csv@v#{version}"
  end

  def self.postinstall
    ExitMessage.add "\nType 'json2csv -h' to get started.\n"
  end
end
