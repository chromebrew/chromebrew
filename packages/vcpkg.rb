require 'package'

class Vcpkg < Package
  description 'C++ Library Manager for Windows, Linux, and MacOS'
  homepage 'https://github.com/microsoft/vcpkg'
  version '2025.07.25'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/microsoft/vcpkg.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd83257325d352eddb3d880f10cf03ec3982ba826198f45fc8967930ef10aa8c1',
     armv7l: 'd83257325d352eddb3d880f10cf03ec3982ba826198f45fc8967930ef10aa8c1',
       i686: 'e35d5be2cc00cc50042f79a60168debbf0c981290a34f68da92ab386ef9bfac7',
     x86_64: 'e62740df23b57ae09fa940304c7e52fbb040e24bde36acf40ddeb12f90d6bad8'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    ENV['VCPKG_FORCE_SYSTEM_BINARIES'] = 'ON'
    # See https://github.com/microsoft/vcpkg/issues/44783
    ENV['CMAKE_POLICY_VERSION_MINIMUM'] = '3.5'
    system './bootstrap-vcpkg.sh'
  end

  def self.install
    FileUtils.install 'vcpkg', "#{CREW_DEST_PREFIX}/bin/vcpkg", mode: 0o755
    FileUtils.install 'scripts/vcpkg_completion.bash', "#{CREW_DEST_PREFIX}/etc/env.d/vcpkg_completion.bash", mode: 0o644
  end
end
