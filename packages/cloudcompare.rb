require 'buildsystems/cmake'

class Cloudcompare < CMake
  description '3D point cloud and mesh processing software'
  homepage 'https://www.cloudcompare.org/'
  version '2.13.2'
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/CloudCompare/CloudCompare.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b9dcae58bee20d53d053074163514ccd234a051dd1323809d300b3ff64367f14',
     armv7l: 'b9dcae58bee20d53d053074163514ccd234a051dd1323809d300b3ff64367f14',
       i686: 'bc718988f578d8fb55ba7d06907810779e0d31270e6f2cb53d261bc5f62d0eef',
     x86_64: '4215d85d838c7945b9e57fffb3e0ee186d6013b46d37a178aaa5bcee0d8108e9'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libglvnd' => :library
  depends_on 'qt5_base' => :library
  depends_on 'qt5_svg' => :library
  depends_on 'qt5_tools' => :library
  depends_on 'sommelier' => :logical

  cmake_options '-DCMAKE_POLICY_VERSION_MINIMUM=3.5'

  def self.postinstall
    ExitMessage.add "\nType 'CloudCompare' to get started.\n"
  end
end
