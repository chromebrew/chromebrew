require 'package'

class Dart < Package
  description 'The Dart SDK is a set of tools and libraries for the Dart programming language.  You can find information about Dart online at dartlang.org.'
  homepage 'https://dart.dev/'
  @_ver = '2.17.6'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url({
    aarch64: "https://storage.googleapis.com/dart-archive/channels/stable/release/#{@_ver}/sdk/dartsdk-linux-arm-release.zip",
     armv7l: "https://storage.googleapis.com/dart-archive/channels/stable/release/#{@_ver}/sdk/dartsdk-linux-arm-release.zip",
       i686: "https://storage.googleapis.com/dart-archive/channels/stable/release/#{@_ver}/sdk/dartsdk-linux-ia32-release.zip",
     x86_64: "https://storage.googleapis.com/dart-archive/channels/stable/release/#{@_ver}/sdk/dartsdk-linux-x64-release.zip"
  })
  source_sha256({
    aarch64: '3eae7ed5773c125165d123a235bac9956981cfdf164059806ed69a6feefc1eda',
     armv7l: '3eae7ed5773c125165d123a235bac9956981cfdf164059806ed69a6feefc1eda',
       i686: '339133593726375213fca6156288fbdcb4c0644d725f8531910449edca2315fa',
     x86_64: 'f837f385603a1cfb14ddb7dd0cd64820b297646626bdb689ccfc3278fa83b2b1'
  })

  no_compile_needed

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
    FileUtils.cp_r 'bin/', CREW_DEST_PREFIX
    FileUtils.cp_r 'include/', CREW_DEST_PREFIX
    FileUtils.cp_r Dir['lib/*'], CREW_DEST_LIB_PREFIX
    FileUtils.cp 'version', CREW_DEST_PREFIX # This stops 'pub get' from throwing errors
  end
end
