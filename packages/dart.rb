require 'package'

class Dart < Package
  description 'The Dart SDK is a set of tools and libraries for the Dart programming language.  You can find information about Dart online at dartlang.org.'
  homepage 'https://www.dartlang.org'
  version '2.9.1'
  compatibility 'all'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://storage.googleapis.com/dart-archive/channels/stable/release/2.9.1/sdk/dartsdk-linux-arm-release.zip'
    source_sha256 'e393c05136571bf7c4879a2bfe207a768be449a3d0bcc8a7ff700b01c4330109'
  when 'i686'
    source_url 'https://storage.googleapis.com/dart-archive/channels/stable/release/2.9.1/sdk/dartsdk-linux-ia32-release.zip'
    source_sha256 '8492ec94a07c6100f1a097864668e4b9063f3b1ed9f05c01dee2d59158ae6a04'
  when 'x86_64'
    source_url 'https://storage.googleapis.com/dart-archive/channels/stable/release/2.9.1/sdk/dartsdk-linux-x64-release.zip'
    source_sha256 '8e092105482e3e1be90af44962e3b7973a20cd8f71aa9f6e07199174a58e0eed'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}"
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}"
    FileUtils.cp_r 'bin/', "#{CREW_DEST_PREFIX}"
    FileUtils.cp_r 'include/', "#{CREW_DEST_PREFIX}"
    FileUtils.cp_r Dir.glob('lib/*'), "#{CREW_DEST_LIB_PREFIX}"
    FileUtils.cp 'version', "#{CREW_DEST_PREFIX}" # This stops 'pub get' from throwing errors
  end
end
