require 'package'

class Libproxy < Package
  description 'libproxy is a library that provides automatic proxy configuration management.'
  homepage 'http://libproxy.github.io/libproxy/'
  version '0.4.15'
  compatibility 'all'
  source_url 'https://github.com/libproxy/libproxy/releases/download/0.4.15/libproxy-0.4.15.tar.xz'
  source_sha256 '654db464120c9534654590b6683c7fa3887b3dad0ca1c4cd412af24fbfca6d4f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libproxy-0.4.15-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libproxy-0.4.15-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libproxy-0.4.15-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libproxy-0.4.15-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f0df6d6fbe49b9783ebe03bf922cb917714358dc4380c44dfa9b5bbdc747d831',
     armv7l: 'f0df6d6fbe49b9783ebe03bf922cb917714358dc4380c44dfa9b5bbdc747d831',
       i686: '00c146655e1bf4c437974ad59549b900924ac93f7de277477c196c56c44b7c73',
     x86_64: '896073cbf37b750da1856e37c58111f4c1350196ddb6fef5ce7799197d7a9f27',
  })

  def self.build
    system './autogen.sh'
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "cmake .. -DLIB_INSTALL_DIR=#{CREW_LIB_PREFIX}"
    end
    system 'make'
  end

  def self.install
    system "make", "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
