require 'package'

class Neofetch < Package
  description 'A fast, highly customizable system info script'
  homepage 'https://github.com/dylanaraps/neofetch'
  version '7.1.0-ccd5-1'
  license 'MIT-with-advertising'
  compatibility 'all'
  source_url 'https://github.com/dylanaraps/neofetch.git'
  git_hashtag 'ccd5d9f52609bbdcd5d8fa78c4fdb0f12954125f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b6ad1e1d891b0dac7c12e865a8409a2c80893123fb3a78f9b50561dc05bd39f0',
     armv7l: 'b6ad1e1d891b0dac7c12e865a8409a2c80893123fb3a78f9b50561dc05bd39f0',
       i686: '8db3aa8412ff282cc8e42b838356aedacde1668060b76924e5714dd32a9a67fd',
     x86_64: 'ddf5a899ec83cab34ba0f73b9edbf0a555539c604256115d90308a32210eefa1'
  })

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "PREFIX=#{CREW_PREFIX}", 'install'
  end
end
