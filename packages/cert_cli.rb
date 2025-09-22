require 'package'

class Cert_cli < Package
  description 'An OSINT tool for discovering domains, organizations, and addresses from SSL/TLS certificates using crt.sh.'
  homepage 'https://github.com/mihneamanolache/cert-cli'
  version '1.0.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/mihneamanolache/cert-cli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0ca2c114a0565d0bce0f02f1f69e2ea7984eeff1a490b06f4aaa0d9d62cfcee0',
     armv7l: '0ca2c114a0565d0bce0f02f1f69e2ea7984eeff1a490b06f4aaa0d9d62cfcee0',
       i686: 'a04d2b39dc4fea76eb2eaa2807bc9f241f3a5f136114bf7e49c10936cb08cb05',
     x86_64: '67dabe47e3fccabf7a8a057efb6dd0c5e0b4315dd413b6ac8f9d6fb3ef4dd839'
  })

  depends_on 'glibc' # R
  depends_on 'go' => :build

  def self.install
    system "go build -o #{CREW_DEST_PREFIX}/bin/cert-cli cmd/main.go"
  end

  def self.postinstall
    ExitMessage.add "\nType 'cert-cli -h' to get started.\n"
  end
end
