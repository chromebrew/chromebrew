require 'package'

class Libproxy < Package
  description 'libproxy is a library that provides automatic proxy configuration management.'
  homepage 'http://libproxy.github.io/libproxy/'
  version '0.4.15'
  source_url 'https://github.com/libproxy/libproxy/releases/download/0.4.15/libproxy-0.4.15.tar.xz'
  source_sha256 '654db464120c9534654590b6683c7fa3887b3dad0ca1c4cd412af24fbfca6d4f'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'cmake' => :build

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
