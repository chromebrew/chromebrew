require 'package'

class Dart < Package
  description 'The Dart SDK is a set of tools and libraries for the Dart programming language.  You can find information about Dart online at dartlang.org.'
  homepage 'https://dart.dev/'
  @_ver = '2.13.4'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url "https://storage.googleapis.com/dart-archive/channels/stable/release/#{@_ver}/sdk/dartsdk-linux-arm-release.zip"
    source_sha256 'f7733f30e44345237a817bf9104fee1e20820a5796162770b964adcaf705711d'
  when 'i686'
    source_url "https://storage.googleapis.com/dart-archive/channels/stable/release/#{@_ver}/sdk/dartsdk-linux-ia32-release.zip"
    source_sha256 '3116ac10532ec954d0dd31b99cb562279109909ba818dbe081b1c2059a8f50b8'
  when 'x86_64'
    source_url "https://storage.googleapis.com/dart-archive/channels/stable/release/#{@_ver}/sdk/dartsdk-linux-x64-release.zip"
    source_sha256 '633a9aa4812b725ff587e2bbf16cd5839224cfe05dcd536e1a74804e80fdb4cd'
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
    FileUtils.cp_r 'bin/', CREW_DEST_PREFIX
    FileUtils.cp_r 'include/', CREW_DEST_PREFIX
    FileUtils.cp_r Dir.glob('lib/*'), CREW_DEST_LIB_PREFIX
    FileUtils.cp 'version', CREW_DEST_PREFIX # This stops 'pub get' from throwing errors
  end
end
