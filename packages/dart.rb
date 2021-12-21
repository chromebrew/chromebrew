require 'package'

class Dart < Package
  description 'The Dart SDK is a set of tools and libraries for the Dart programming language.  You can find information about Dart online at dartlang.org.'
  homepage 'https://dart.dev/'
  @_ver = '2.14.4'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url "https://storage.googleapis.com/dart-archive/channels/stable/release/#{@_ver}/sdk/dartsdk-linux-arm-release.zip"
    source_sha256 '796b64022615ea75f05f20a3d5e7018e52a1d26c06acb1d2b0b2faa5df491a64'
  when 'i686'
    source_url "https://storage.googleapis.com/dart-archive/channels/stable/release/#{@_ver}/sdk/dartsdk-linux-ia32-release.zip"
    source_sha256 'f6b73006af2e3bd1394877f2e539ef88ae6a93968a56d4124e3b0b5d68b4de36'
  when 'x86_64'
    source_url "https://storage.googleapis.com/dart-archive/channels/stable/release/#{@_ver}/sdk/dartsdk-linux-x64-release.zip"
    source_sha256 '49b6a98008ef546cb9c221461529d6c02cf2474bff098e0dc7e4ff1ef0f8a289'
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
