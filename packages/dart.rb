require 'package'

class Dart < Package
  description 'The Dart SDK is a set of tools and libraries for the Dart programming language.  You can find information about Dart online at dartlang.org.'
  homepage 'https://www.dartlang.org'
  version '2.7.0'
  compatibility 'all'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://storage.googleapis.com/dart-archive/channels/stable/release/2.7.0/sdk/dartsdk-linux-arm-release.zip'
    source_sha256 '2270ae2d3e467c539dcc6358312bba949f2614f7da78225e7a1ba5b57981ca0c'
  when 'i686'
    source_url 'https://storage.googleapis.com/dart-archive/channels/stable/release/2.7.0/sdk/dartsdk-linux-ia32-release.zip'
    source_sha256 'a503731077c332fbde70c06b602efc5024d59e7331f08dba087d2d8bbf4e6c23'
  when 'x86_64'
    source_url 'https://storage.googleapis.com/dart-archive/channels/stable/release/2.7.0/sdk/dartsdk-linux-x64-release.zip'
    source_sha256 '65844622eb095be903d057d78af4826bfc204d8ea156f77a14b954520f019827'
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
