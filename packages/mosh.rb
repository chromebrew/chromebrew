require 'package'

class Mosh < Package
  description 'Remote terminal application that allows roaming, supports intermittent connectivity, and provides intelligent local echo and line editing of user keystrokes.'
  homepage 'https://mosh.org/'
  version '1.3.2'
  source_url 'https://mosh.org/mosh-1.3.2.tar.gz'
  source_sha256 'da600573dfa827d88ce114e0fed30210689381bbdcff543c931e4d6a2e851216'

  depends_on 'protobuf'

  def self.build
    system './configure --prefix=/usr/local'
    system 'make'
  end

  def self.install
    system 'make install'
  end
end
