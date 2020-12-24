require 'package'

class Libssh < Package
  description 'libssh is a multiplatform C library implementing the SSHv2 and SSHv1 protocol on client and server side.'
  homepage 'https://www.libssh.org/'
  version '0.9.5'
  compatibility 'all'
  source_url 'https://www.libssh.org/files/0.9/libssh-0.9.5.tar.xz'
  source_sha256 'acffef2da98e761fc1fd9c4fddde0f3af60ab44c4f5af05cd1b2d60a3fa08718'

  depends_on 'libgcrypt'
    
  def self.patch
      `echo "$(sed '/\# global needed variable/a set\(CMAKE_C_FLAGS \"-fstack-protector-strong\"\)~\
add_compile_options\(-fstack-protector-strong\)~\
link_libraries\(-fstack-protector-strong\)' CMakeLists.txt)" > ./CMakeLists.txt`
      `echo "$(tr '~' '\n' < CMakeLists.txt)" > CMakeLists.txt`
  end
  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "cmake \
             #{CREW_CMAKE_OPTIONS} \
             -DWITH_GCRYPT=ON \
             .."
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
