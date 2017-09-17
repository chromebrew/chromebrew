require 'package'

class Elixir < Package
  description 'Elixir is a dynamic, functional language designed for building scalable and maintainable applications.'
  homepage 'http://elixir-lang.org/'
  version '1.5.1'
  source_url 'https://github.com/elixir-lang/elixir/releases/download/v1.5.1/Precompiled.zip'
  source_sha256 '84af6eb4cb68d0f60b3edf4e275eb024f8eb8cccae91b18c2bbbc4b70a88934f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/elixir-1.5.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/elixir-1.5.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/elixir-1.5.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/elixir-1.5.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '54a5afb5f1a6ac89dde31da18c8d8c0982de24a8f6235fb6dc680bf4faeb1962',
     armv7l: '54a5afb5f1a6ac89dde31da18c8d8c0982de24a8f6235fb6dc680bf4faeb1962',
       i686: 'a9e86ddd0120238198f7aea64b148818034b7d9a75b7f56f8c1b79c67bae5098',
     x86_64: '01a4e221a51f9c73ab55906c1d1b9676435a551743482c72c16200ad62c4648e',
  })

  depends_on 'erlang'
  depends_on 'unzip'

  def self.build
    # do noting
  end

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}#{CREW_PREFIX}"
    system "mkdir -p #{CREW_DEST_DIR}#{CREW_PREFIX}/share"
    system "mv bin #{CREW_DEST_DIR}#{CREW_PREFIX}"
    system "mv lib #{CREW_DEST_DIR}#{CREW_PREFIX}"
    system "mv man #{CREW_DEST_DIR}#{CREW_PREFIX}/share"
  end
end
