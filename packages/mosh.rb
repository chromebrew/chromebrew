require 'package'

class Mosh < Package
  description 'Remote terminal application that allows roaming, supports intermittent connectivity, and provides intelligent local echo and line editing of user keystrokes.'
  homepage 'https://mosh.org/'
  version '1.3.0'
  source_url 'https://mosh.org/mosh-1.3.0.tar.gz'
  source_sha256 '320e12f461e55d71566597976bd9440ba6c5265fa68fbf614c6f1c8401f93376'

  depends_on 'protobuf'

  def self.build
    system './configure --prefix=/usr/local'
    system 'make'
  end

  def self.install
    system 'make install'
  end
end
