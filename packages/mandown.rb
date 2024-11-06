# Adapted from Arch Linux mandown PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mandown/trunk/PKGBUILD

require 'package'

class Mandown < Package
  description 'Create man pages from markdown markup'
  homepage 'https://gitlab.com/kornelski/mandown'
  version '0.1.3'
  license 'Apache'
  compatibility 'all'
  source_url 'https://gitlab.com/kornelski/mandown.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd1a43979ef4adc22634ec737760800d5b4afdaddae3608659c7429e1ac4567d0',
     armv7l: 'd1a43979ef4adc22634ec737760800d5b4afdaddae3608659c7429e1ac4567d0',
       i686: '8af281af379eb2de023254b6272adeee85502a6c7d3d1d152c4b543b6cb81144',
     x86_64: 'e6b8e8859b2ecf65401b6b02f1960b731a6e7c64b92095a86c3e661fd6a38e27'
  })

  depends_on 'rust' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    system 'cargo build --release --all-features --target-dir=target'
  end

  def self.install
    system 'cargo build --release --locked --all-features --target-dir=target'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'target/release/mandown', "#{CREW_DEST_PREFIX}/bin", mode: 0o755
  end
end
