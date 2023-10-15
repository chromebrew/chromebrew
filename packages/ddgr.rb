require 'package'

class Ddgr < Package
  description 'DuckDuckGo from the terminal'
  homepage 'https://github.com/jarun/ddgr'
  version '2.1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/jarun/ddgr.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ddgr/2.1_armv7l/ddgr-2.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ddgr/2.1_armv7l/ddgr-2.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ddgr/2.1_i686/ddgr-2.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ddgr/2.1_x86_64/ddgr-2.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '77e8bb3cb62004313c987664af947219cdbaa40bb95d643960cf5138db9a9d9a',
     armv7l: '77e8bb3cb62004313c987664af947219cdbaa40bb95d643960cf5138db9a9d9a',
       i686: '843b29f4c5e8d526b563505f391a420146780dc3760def2179b1f4843bdc7caa',
     x86_64: '3ad3923836b3bfe7a97d81c827f6953b74dc43657331f5f91fdec7159d452815'
  })

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
