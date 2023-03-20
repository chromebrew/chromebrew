require 'package'

class Cloudcross < Package
  description 'The CloudCross is an open source project for a synchronization between your devices and various cloud storages.'
  homepage 'https://cloudcross.mastersoft24.ru/'
  version '1.4.8'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/MasterSoft24/CloudCross/archive/v1.4.8.tar.gz'
  source_sha256 'fe8ddc608b4aa099b841f5f13fd3ba7296f56c3e24ec2a63537b160715e3fa1b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cloudcross/1.4.8_armv7l/cloudcross-1.4.8-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cloudcross/1.4.8_armv7l/cloudcross-1.4.8-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cloudcross/1.4.8_i686/cloudcross-1.4.8-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cloudcross/1.4.8_x86_64/cloudcross-1.4.8-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9ec558a90c340609af60fe5c745dd19cdf484fe48724a4090410908ada3d9818',
     armv7l: '9ec558a90c340609af60fe5c745dd19cdf484fe48724a4090410908ada3d9818',
       i686: 'a129f7f95723aceb1f3740d92ce7f5887ccc4355ee18d9a862afb3cf8718a611',
     x86_64: 'b36c6764610ad51c82bc930b701968863bde93057ce11436b7a9cb9d41c3e398'
  })

  depends_on 'curl'
  depends_on 'qtbase' => :build

  def self.build
    dirs = %w[ccross-app ccross-curl-executor]
    dirs.each do |dir|
      Dir.chdir dir do
        system 'qmake && make'
      end
    end
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    apps = %w[ccross-app/ccross ccross-curl-executor/ccross-curl]
    FileUtils.install apps, "#{CREW_DEST_PREFIX}/bin", mode: 0o755
  end

  def self.postinstall
    puts "\nEnter 'ccross -a' to get started.\n".lightblue
  end
end
