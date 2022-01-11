require 'package'

class Dart < Package
  description 'The Dart SDK is a set of tools and libraries for the Dart programming language.  You can find information about Dart online at dartlang.org.'
  homepage 'https://dart.dev/'
  @_ver = '2.15.1'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url "https://storage.googleapis.com/dart-archive/channels/stable/release/#{@_ver}/sdk/dartsdk-linux-arm-release.zip"
    source_sha256 '751935fc08dec2121410c3f2f33de8215d8a4e5f21192a4c42c4b81dd00f8659'
  when 'i686'
    source_url "https://storage.googleapis.com/dart-archive/channels/stable/release/#{@_ver}/sdk/dartsdk-linux-ia32-release.zip"
    source_sha256 '491ab94edc52f9bc02a95c5ad14d99867f09d56b66e0e9eafb7b904bef79d6cc'
  when 'x86_64'
    source_url "https://storage.googleapis.com/dart-archive/channels/stable/release/#{@_ver}/sdk/dartsdk-linux-x64-release.zip"
    source_sha256 '0f45dcaa53b4090b69b277b885ea9a4cb3a41589c9119113e1b978ad55ce335f'
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
    FileUtils.cp_r 'bin/', CREW_DEST_PREFIX
    FileUtils.cp_r 'include/', CREW_DEST_PREFIX
    FileUtils.cp_r Dir['lib/*'], CREW_DEST_LIB_PREFIX
    FileUtils.cp 'version', CREW_DEST_PREFIX # This stops 'pub get' from throwing errors
  end
end
