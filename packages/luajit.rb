require 'package'

class Luajit < Package
  description 'LuaJIT is a Just-In-Time Compiler (JIT) for the Lua programming language.'
  homepage 'https://github.com/openresty/luajit2'
  version '2.1-a2bde60'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/LuaJIT/LuaJIT.git'
  git_hashtag 'a2bde60819d83e6f75130ac2c93ee4b3c7615800'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '61abdef0c3c0aa01cc98aff0ea9bf9eac0c450d1ac35947281922db8437f24b5',
     armv7l: '61abdef0c3c0aa01cc98aff0ea9bf9eac0c450d1ac35947281922db8437f24b5',
       i686: '07025217c7888946b51fab7783a7e9ceb9800e69b88afb826717d59327b2970e',
     x86_64: 'c549610c77905f3919a67ed62c61bc5348adfe42fa9905a97d017ed544580193'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}", "MULTILIB=#{ARCH_LIB}"
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "MULTILIB=#{ARCH_LIB}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
    Dir.chdir("#{CREW_DEST_PREFIX}/bin") do
      FileUtils.ln_sf Dir["luajit-#{version.split('-').first}*"].first, 'luajit'
    end
  end
end
