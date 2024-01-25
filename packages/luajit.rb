require 'package'

class Luajit < Package
  description 'LuaJIT is a Just-In-Time Compiler (JIT) for the Lua programming language.'
  homepage 'https://github.com/openresty/luajit2'
  version '2.1-6c4826f'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/LuaJIT/LuaJIT/archive/6c4826f12c4d33b8b978004bc681eb1eef2be977.zip'
  source_sha256 '4a384b218557e650e6fbbe2e0f14aa7a7d08a3e1f31eedbfc54de1cc62583496'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'af723c53d04e905531d9f3497017bc0d65be32be3c6613f518e72ed7f53de0b6',
     armv7l: 'af723c53d04e905531d9f3497017bc0d65be32be3c6613f518e72ed7f53de0b6',
       i686: 'ead1b0c1e413199a63d2b729daede0242188e1bb951408cad050483723ac459e',
     x86_64: 'c4bfd99b5d7098acf0cd890b409a4b2a444c3f90b34bdfc0d356a4bcaf3c50e6'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}", "MULTILIB=#{ARCH_LIB}"
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "MULTILIB=#{ARCH_LIB}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
    Dir.chdir("#{CREW_DEST_PREFIX}/bin") do
      FileUtils.ln_s 'luajit-2.1.0-beta3', 'luajit'
    end
  end
end
