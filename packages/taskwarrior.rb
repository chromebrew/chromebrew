require 'buildsystems/cmake'

class Taskwarrior < CMake
  description 'Free and Open Source Software that manages your TODO list from the command line.'
  homepage 'https://taskwarrior.org/'
  version '3.6.0'
  license 'MIT'
  compatibility 'all'
  source_url "https://github.com/GothenburgBitFactory/taskwarrior/releases/download/v#{version}/task-#{version}.tar.gz"
  source_sha256 '2873ca80feb03ac202816d69a57f06403bf1c2d7ca082ac9f3aa06ad9f1d7a8a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a09e0b00b3d5c8f1cfe732c598b2b2fa568f2cad90d3b3044541b0f610689c87',
     armv7l: 'a09e0b00b3d5c8f1cfe732c598b2b2fa568f2cad90d3b3044541b0f610689c87',
       i686: '88acc23e9f160efbf2f23a18d058e1857700d784bf75be323bde5ea37129476d',
     x86_64: '89c5c0700fc95ba3dd94ea58f7f626cdcd7c3a3647dca2611b163435c4dec442'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'llvm_dev' => :build
  depends_on 'rust' => :build
  depends_on 'util_linux' => :executable

  def self.postinstall
    ExitMessage.add "\nType 'man task' for help to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.task")
    Package.agree_to_remove("#{HOME}/.config/task")
    Package.agree_to_remove("#{HOME}/.taskrc")
  end
end
