require 'package'

class Mosh < Package
  description 'Remote terminal application that allows roaming, supports intermittent connectivity, and provides intelligent local echo and line editing of user keystrokes.'
  homepage 'https://mosh.org/'
  version '1.3.0'
  source_url 'https://mosh.org/mosh-1.3.0.tar.gz'
  source_sha1 '846698806d940c84028c04f68e289e31d9540d5f'

  depends_on 'protobuf'

  def self.build
    system './configure --prefix=/usr/local'
    system 'make'
  end

  def self.install
    system 'make install'
  end
end
