require 'package'

class Dart < Package
  description 'The Dart SDK is a set of tools and libraries for the Dart programming language.  You can find information about Dart online at dartlang.org.'
  homepage 'https://www.dartlang.org'
  version '2.9.3'
  compatibility 'all'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://storage.googleapis.com/dart-archive/channels/stable/release/2.9.3/sdk/dartsdk-linux-arm-release.zip'
    source_sha256 'fe5e180c901b4a6bf802211bf7b4918d321c3924f55088339f7fe3a01a8cc735'
  when 'i686'
    source_url 'https://storage.googleapis.com/dart-archive/channels/stable/release/2.9.3/sdk/dartsdk-linux-ia32-release.zip'
    source_sha256 '82116dbc7e16ca4bd04c090be2bb6014bce8d0a71823a1ffdc5842b658b6132c'
  when 'x86_64'
    source_url 'https://storage.googleapis.com/dart-archive/channels/stable/release/2.9.3/sdk/dartsdk-linux-x64-release.zip'
    source_sha256 '6719026f526f3171274dc9d8322c33fd9ec22e659e8dd833c587038211b83b04'
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
