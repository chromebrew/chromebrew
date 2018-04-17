require 'package'

class Yarn < Package
  description 'Yarn is a new package manager for JavaScript and an alternative to npm.'
  homepage 'https://yarnpkg.com/en/'
  version '1.6.0'
  source_url 'https://github.com/yarnpkg/yarn/releases/download/v1.6.0/yarn-v1.6.0.tar.gz'
  source_sha256 'a57b2fdb2bfeeb083d45a883bc29af94d5e83a21c25f3fc001c295938e988509'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/yarn-1.6.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/yarn-1.6.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/yarn-1.6.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/yarn-1.6.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3c85013806518b087950a93ff2b5bdbc986a79dd56f93063a24eff1d785657f7',
     armv7l: '3c85013806518b087950a93ff2b5bdbc986a79dd56f93063a24eff1d785657f7',
       i686: '53303cb77b189f5a166d2b3efaac3e840c89f61ea49bf9ab6fc3b7bf724c7bc1',
     x86_64: 'db01d493bcc9277d259681806871eeb99161ce2857fb5843ab880d966cafd5fb',
  })

  node_version=`node -v 2> /dev/null`
  depends_on 'nodebrew' unless "#{node_version}" != ""

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}"
    system "cp -r lib/ #{CREW_DEST_PREFIX}"
    system "cp -r bin/ #{CREW_DEST_PREFIX}"
  end
end
