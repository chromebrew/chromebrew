require 'package'

class Entr < Package
  description 'Run arbitrary commands when files change'
  homepage 'https://eradman.com/entrproject/'
  version '5.6'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/eradman/entr.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6d79a63e1ac8156f348d3c4c32b9c460f3f6224a5721a0a6bbd9bfe5b5e4f80a',
     armv7l: '6d79a63e1ac8156f348d3c4c32b9c460f3f6224a5721a0a6bbd9bfe5b5e4f80a',
       i686: 'ccf9946cf98aa951b8223c209c9deb0ab48d32d597c10a61da2387ea2497f286',
     x86_64: 'cfc15cb06370c5fd548060fcd06b3935520fb57d89d82abfef7c4ce2c6d6d4b9'
  })

  def self.build
    system './configure' # Not an autotools script, despite appearances.
    system 'make', "PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
