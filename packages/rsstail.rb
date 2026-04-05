require 'package'

class Rsstail < Package
  description 'Monitor and print rss feeds tail for rss...'
  homepage 'https://github.com/oldlaptop/rsstail'
  version '2.2'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://github.com/folkertvanheusden/rsstail.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '907a200dca02bb57b9fdf409c66b7e8643ea937b7117cefb5f507f3ee5ba1a54',
     armv7l: '907a200dca02bb57b9fdf409c66b7e8643ea937b7117cefb5f507f3ee5ba1a54',
       i686: 'cc864043553fde5d4069650b653ba2d82381d89092094bfb726ec580faad7e1b',
     x86_64: '1f11d5133693f9d4dedb349d95739b0edc440ec9472180a4bcbd5cd93e8240e3'
  })

  depends_on 'git' => :build
  depends_on 'glibc' => :executable
  depends_on 'libmrss' => :executable

  def self.build
    system 'make'
  end

  def self.install
    %w[bin share/man/man1].map { FileUtils.mkdir_p "#{CREW_DEST_PREFIX}#{it}" }
    system "make prefix=#{CREW_DEST_PREFIX} install"
  end
end
