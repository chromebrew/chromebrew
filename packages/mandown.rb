# Adapted from Arch Linux mandown PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mandown/trunk/PKGBUILD

require 'package'

class Mandown < Package
  description 'Create man pages from markdown markup'
  homepage 'https://gitlab.com/kornelski/mandown'
  version '1.1.0'
  license 'Apache'
  compatibility 'all'
  source_url 'https://gitlab.com/kornelski/mandown.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ff6f389687e40955b5924f9917179f96859925a21cf688f45fc5692f71853b73',
     armv7l: 'ff6f389687e40955b5924f9917179f96859925a21cf688f45fc5692f71853b73',
       i686: '4c09ae9c972798e29cd9e397e5d0fa3d9f25a70879d4b5e15b83d4bd176f60e2',
     x86_64: '0c7039702eb592970baec29f9730b695ee5e2adaa9b235e44d5cdafaab7ce5b5'
  })

  depends_on 'gcc_lib' => :executable_only
  depends_on 'glibc' => :executable_only
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
