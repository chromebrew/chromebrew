# Adapted from Arch Linux mandown PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mandown/trunk/PKGBUILD

require 'package'

class Mandown < Package
  description 'Create man pages from markdown markup'
  homepage 'https://gitlab.com/kornelski/mandown'
  version '0.1.2'
  license 'Apache'
  compatibility 'all'
  source_url 'https://gitlab.com/kornelski/mandown.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mandown/0.1.2_armv7l/mandown-0.1.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mandown/0.1.2_armv7l/mandown-0.1.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mandown/0.1.2_i686/mandown-0.1.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mandown/0.1.2_x86_64/mandown-0.1.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9f4efe76ecd382186577c77742743227fce401bd5e26ccda4abd1db62caa5b3e',
     armv7l: '9f4efe76ecd382186577c77742743227fce401bd5e26ccda4abd1db62caa5b3e',
       i686: '9393b4c96cf55dd80af49742481889554776baef3f6450494ea15fee1f7192f4',
     x86_64: '921636c6aefbba2ab7a1fcc0e27f577b02b40ffbe841f6e837ff676a11b9d52e'
  })

  depends_on 'rust' => ':build'

  def self.build
    system 'cargo build --release --all-features --target-dir=target'
  end

  def self.install
    system 'cargo build --release --locked --all-features --target-dir=target'
    system "install -Dm 755 target/release/mandown -t #{CREW_DEST_PREFIX}/bin"
  end
end
