require 'package'

class Heroku < Package
  description 'The Heroku Command Line Interface (CLI), formerly known as the Heroku Toolbelt, is a tool for creating and managing Heroku apps from the command line / shell of various operating systems.'
  homepage 'https://devcenter.heroku.com/articles/heroku-cli'
  version '7.44.0'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://github.com/heroku/cli/archive/v7.44.0.tar.gz'
  source_sha256 '565e2a42a5095da43466465f29455ea646b235742f16b667d58da0a312c0fe8a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-7.44.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-7.44.0-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/heroku-7.44.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '60c419195c5a9c40b9bccc18d9da7d50a122e6609784a85c3fd5ea9f882bcf26',
     armv7l: '60c419195c5a9c40b9bccc18d9da7d50a122e6609784a85c3fd5ea9f882bcf26',
     x86_64: 'fa9b538dd683248d3e892f8a74c16c2a124dc189e4b9b0b18c17e57897b93096',
  })

  depends_on 'yarn' => :build

  def self.build
    system 'yarn install'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/share/heroku"
    system "cp -r . #{CREW_DEST_PREFIX}/share/heroku"
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "ln -s #{CREW_PREFIX}/share/heroku/bin/run #{CREW_DEST_PREFIX}/bin/heroku"
  end
end
