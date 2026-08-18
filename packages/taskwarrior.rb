require 'buildsystems/cmake'

class Taskwarrior < CMake
  description 'Free and Open Source Software that manages your TODO list from the command line.'
  homepage 'https://taskwarrior.org/'
  version '3.5.0'
  license 'MIT'
  compatibility 'all'
  source_url "https://github.com/GothenburgBitFactory/taskwarrior/releases/download/v#{version}/task-#{version}.tar.gz"
  source_sha256 '9ea64b411f8314414f440ec765dfdf5a86c9f6159df47e2f60cff3db6b31157a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '65380b475f3d78162f310c8ca629f63bf58b65fe9f49d7e3d9fcf472fa2807ab',
     armv7l: '65380b475f3d78162f310c8ca629f63bf58b65fe9f49d7e3d9fcf472fa2807ab',
       i686: '3c5a52de156aaab82b7329db564f850172558180eab8889e56b9da469126ce82',
     x86_64: '749d58b626149f940437902a05dc6299ce7e973f9d824d75cbe8e08114441b0b'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
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
