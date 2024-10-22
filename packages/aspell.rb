require 'buildsystems/autotools'

class Aspell < Autotools
  description 'GNU Aspell is a Free and Open Source spell checker designed to eventually replace Ispell.'
  homepage 'http://aspell.net/'
  version '0.60.8.1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/GNUAspell/aspell.git'
  git_hashtag "rel-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '67dcb78d4b1a2b04705bd8613863233bc5f2d0133e73b09c95a4b174dc614483',
     armv7l: '67dcb78d4b1a2b04705bd8613863233bc5f2d0133e73b09c95a4b174dc614483',
       i686: '48027960da969bd74a6039034f23b6682d7b7894c2762c2b4329d2b7286dc775',
     x86_64: '4d69ecc5b7d9b26e78c8449e7ea6fb93d74b9cce3a390d3e9c74786867e80aa1'
  })

  # https://github.com/GNUAspell/aspell/pull/654
  def self.patch
    # Rename autogen to autogen.sh
    downloader 'https://patch-diff.githubusercontent.com/raw/GNUAspell/aspell/pull/654.patch', '215c99b3ef9a76f8d7623dfcf984ab46dd170c92b07862708a5688691481ab39'
    system 'git apply 654.patch'
  end
end
