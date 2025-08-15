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
    aarch64: 'c852e279f00d95fabdc5963e0f9754c8eef2d8f863fb0a7e47044c008b5595ca',
     armv7l: 'c852e279f00d95fabdc5963e0f9754c8eef2d8f863fb0a7e47044c008b5595ca',
       i686: '383ed77df1d24ea49ef90b53ac4ac2c85a7fb91e88a25bc785c251d3e9eddb39',
     x86_64: '84d872bb42216cac7024ba8e446fe86704de8aa99134fd21deaabf9a8d6fa430'
  })

  depends_on 'cmake' => :build
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
