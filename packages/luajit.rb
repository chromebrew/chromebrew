require 'package'

class Luajit < Package
  description 'LuaJIT is a Just-In-Time Compiler (JIT) for the Lua programming language.'
  homepage 'http://luajit.org/'
  version '2.0.5'
  source_url 'http://luajit.org/download/LuaJIT-2.0.5.tar.gz'
  source_sha256 '874b1f8297c697821f561f9b73b57ffd419ed8f4278c82e05b48806d30c1e979'

  def self.build
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
