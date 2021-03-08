# Adapted from Arch Linux cargo-c PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/cargo-c/trunk/PKGBUILD

require 'package'

class Cargo_c < Package
  description 'A cargo subcommand to build and install C-ABI compatibile dynamic and static libraries'
  homepage 'https://github.com/lu-zero/cargo-c/'
  version '0.7.3'
  compatibility 'all'
  source_url 'https://github.com/lu-zero/cargo-c/archive/v0.7.3/cargo-c-0.7.3.tar.gz'
  source_sha256 '533c65d555330e86b91415753efc140ffdb900abd59b5b6403352c4264941a99'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cargo_c-0.7.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cargo_c-0.7.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cargo_c-0.7.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cargo_c-0.7.3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '9063b96616c64d564f99cd16611ca86f8b8a72a88f5afd03582aaba51941acea',
     armv7l: '9063b96616c64d564f99cd16611ca86f8b8a72a88f5afd03582aaba51941acea',
       i686: '3618f6dc7d77a526c22ed2dd05ea46af032b812d01c5f93c1f8546192d41acbf',
     x86_64: 'de92ff24a09ed7d26f0b8490e174c83ff9941ab33b417a8d20243d0f85d18ef3'
  })

  depends_on 'rust' => ':build'

  def self.build
    system "cargo fetch \
      --manifest-path Cargo.toml"
    system "cargo build \
      --release \
      --frozen \
      --manifest-path Cargo.toml"
  end

  def self.install
    system "cargo install \
      --frozen \
      --offline \
      --no-track \
      --path . \
      --root #{CREW_DEST_PREFIX}"
    # Dir.glob("#{CREW_DEST_PREFIX}/bin/*") do |filename|
    # new_filename = filename.sub('cargo-', '')
    # puts "Renaming #{filename} to #{new_filename} ..."
    # File.rename(filename, new_filename)
    # end
  end
end
