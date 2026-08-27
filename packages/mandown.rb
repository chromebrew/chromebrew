# Adapted from Arch Linux mandown PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mandown/trunk/PKGBUILD

require 'package'

class Mandown < Package
  description 'Create man pages from markdown markup'
  homepage 'https://gitlab.com/kornelski/mandown'
  version '1.1.1'
  license 'Apache'
  compatibility 'all'
  source_url 'https://gitlab.com/kornelski/mandown.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ccca78ff0c16a1c1270141927bfbb8e17f6267d0acb0693dbe30255342754e54',
     armv7l: 'ccca78ff0c16a1c1270141927bfbb8e17f6267d0acb0693dbe30255342754e54',
       i686: '296f52921ea4025a42d86a29b357388e622859a6a31967157123d16316ce7651',
     x86_64: '7a1d1c573cc88caebf981c0e6075c9ca6f04e8890fbdbdfd4c9dda18b3e7b9d0'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'rust' => :build

  def self.build
    system 'cargo build --release --all-features --target-dir=target'
  end

  def self.install
    system 'cargo build --release --locked --all-features --target-dir=target'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'target/release/mandown', "#{CREW_DEST_PREFIX}/bin", mode: 0o755
  end
end
