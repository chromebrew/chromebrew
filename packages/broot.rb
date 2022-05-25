require 'package'

class Broot < Package
  description 'A new way to see and navigate directory trees'
  homepage 'https://dystroy.org/broot'
  version '1.11.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/Canop/broot/archive/v1.11.1.tar.gz'
  source_sha256 '0cc09d5bcc5c6b80d6161c2ba234df0332c1dabd6c3c9f2f6ebe2f82b8eef5c3'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/broot/1.11.1_armv7l/broot-1.11.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/broot/1.11.1_armv7l/broot-1.11.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/broot/1.11.1_i686/broot-1.11.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/broot/1.11.1_x86_64/broot-1.11.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8d4aaa0b51e835863c4fe934958b295dcac68439d82b5dcef78f7939421cf131',
     armv7l: '8d4aaa0b51e835863c4fe934958b295dcac68439d82b5dcef78f7939421cf131',
       i686: 'aa70d49725d6c1010c2655e1065d7681f2f384daab534542d245423d074dfe4f',
     x86_64: '5eed408affc3b87e22994370f0b21566bc05988ab43640c7d949e47cfb6567ec'
  })

  depends_on 'rust' => :build

  def self.build
    system 'cargo fetch \
      --manifest-path Cargo.toml'
    system 'cargo build \
      --release \
      --frozen \
      --manifest-path Cargo.toml'
  end

  def self.install
    system "cargo install \
      --frozen \
      --offline \
      --no-track \
      --path . \
      --root #{CREW_DEST_PREFIX}"
  end
end
