require 'package'

class Jq < Package
  description 'jq is a lightweight and flexible command-line JSON processor.'
  homepage 'https://stedolan.github.io/jq/'
  version '1.6'
  source_url 'https://github.com/stedolan/jq/releases/download/jq-1.6/jq-1.6.tar.gz'
  source_sha256 '5de8c8e29aaa3fb9cc6b47bb27299f271354ebb72514e3accadc7d38b5bbaa72'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'oniguruma'

  def self.build
    system "./configure",
      "--prefix=#{CREW_PREFIX}",
      '--disable-maintainer-mode', # disable make rules and dependencies not useful
      '--disable-docs'             # there's no support for manpages
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
