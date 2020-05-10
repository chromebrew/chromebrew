require 'package'

class Hub < Package
  description 'hub is a command-line wrapper for git that makes you better at GitHub.'
  homepage 'https://hub.github.com/'
  version '2.4.0'
  compatibility 'all'
  source_url 'https://github.com/github/hub/archive/v2.4.0.tar.gz'
  source_sha256 '894eb112be9aa0464fa2c63f48ae8e573ef9e32a00bad700e27fd09a0cb3be4b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/hub-2.4.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/hub-2.4.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/hub-2.4.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/hub-2.4.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cf87b6f4db9da4397e2c3c8c91efe65f6d104238ebac43a74b5ff8e33ea71a79',
     armv7l: 'cf87b6f4db9da4397e2c3c8c91efe65f6d104238ebac43a74b5ff8e33ea71a79',
       i686: 'd2ee1d2942eeaec70926d93ea25dcf30d69fffa55bf017b25dd2a72c0d0a554e',
     x86_64: '6b06e10fc0aa5ae7be07cd74bbae122eca0815d4e2c52dc92f5e11000282bf24',
  })

  depends_on 'go' => :build

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    system "script/build -o #{CREW_DEST_PREFIX}/bin/hub"
    puts
    puts "You will need to add an alias in order to use hub as a git wrapper:".lightblue
    puts "echo \"alias git=hub\" >> ~/.bashrc && source ~/.bashrc".lightblue
    puts
  end
end
