require 'package'

class Yarn < Package
  description 'Yarn is a new package manager for JavaScript and an alternative to npm.'
  homepage 'https://yarnpkg.com/en/'
  version '1.16.0'
  source_url 'https://github.com/yarnpkg/yarn/releases/download/v1.16.0/yarn-v1.16.0.tar.gz'
  source_sha256 'df202627d9a70cf09ef2fb11cb298cb619db1b958590959d6f6e571b50656029'

  binary_url ({
  })
  binary_sha256 ({
  })

  node_version=`node -v 2> /dev/null`
  depends_on 'nodebrew' unless "#{node_version}" != ""

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}"
    system "cp -r lib/ #{CREW_DEST_PREFIX}"
    system "cp -r bin/ #{CREW_DEST_PREFIX}"
  end
end
