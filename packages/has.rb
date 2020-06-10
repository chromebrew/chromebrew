require 'package'

class Has < Package
  description 'checks presence of various command line tools and their versions on the path'
  homepage 'https://github.com/kdabir/has'
  version '1.1.0'
  compatibility 'all'
  source_url 'https://github.com/kdabir/has/archive/v1.1.0.tar.gz'
  source_sha256 'e06d9674bc1b9281c1d4391ad4366d2ef249768e7b0ada304695bf954786e9c4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/has-1.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/has-1.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/has-1.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/has-1.1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9eb67faf4e926a34f1c3e984dd31c47e90d7c67a35447b8f883619ef3ac89d99',
     armv7l: '9eb67faf4e926a34f1c3e984dd31c47e90d7c67a35447b8f883619ef3ac89d99',
       i686: '604bdece05ce6cb408d15b6079bd68961a78b3d9bd347ff8536e82b62231ff89',
     x86_64: '8e08c20871f42de35e7d9bef82cc24e7d5ed9137752dac05c48f36467383a582',
  })

  def self.install
    system "install -Dm755 has #{CREW_DEST_PREFIX}/bin/has"
  end
end
