require 'buildsystems/cmake'

class Taskwarrior < CMake
  description 'Free and Open Source Software that manages your TODO list from the command line.'
  homepage 'https://taskwarrior.org/'
  version '3.2.0'
  license 'MIT'
  compatibility 'all'
  source_url "https://github.com/GothenburgBitFactory/taskwarrior/releases/download/v#{version}/task-#{version}.tar.gz"
  source_sha256 '1a543ba373a319f924a2242c8e0db9dac2691c4cf654c2d0c6827a06b3b32592'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3a36a5a01e828bff4e7790187ca959fc876135f648678b62a790ee73dccca25a',
     armv7l: '3a36a5a01e828bff4e7790187ca959fc876135f648678b62a790ee73dccca25a',
       i686: '323138d15575d05c63b4c342bb0eae49257250a31500319f25e28e11df9642c8',
     x86_64: 'f56cfb583bcb929406da7ac7724c0ff712b883890584b6fc0205bfccd6bb07fb'
  })

  depends_on 'rust' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'util_linux' # R

  def self.postinstall
    ExitMessage.add "\nType 'man task' for help to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.task")
    Package.agree_to_remove("#{HOME}/.config/task")
    Package.agree_to_remove("#{HOME}/.taskrc")
  end
end
