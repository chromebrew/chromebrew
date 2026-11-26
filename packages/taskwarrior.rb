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
    aarch64: '4f103b7ff395d96b75a9fbdacf02f0d20154b180cb038fd601263e94da9a7820',
     armv7l: '4f103b7ff395d96b75a9fbdacf02f0d20154b180cb038fd601263e94da9a7820',
       i686: '8a50aa6fb78b6192e3d763243291a02f183b4e23dd8d54f6d49e3800eabaa293',
     x86_64: '2f375a00d0d5d089e4ecafa0a363bf9a12acb1854bbd4eb889762c5c333400d8'
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
