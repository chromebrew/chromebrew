require 'package'

class Dart < Package
  description 'The Dart SDK is a set of tools and libraries for the Dart programming language.  You can find information about Dart online at dartlang.org.'
  homepage 'https://dart.dev/'
  @_ver = '2.13.0'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url "https://storage.googleapis.com/dart-archive/channels/stable/release/#{@_ver}/sdk/dartsdk-linux-arm-release.zip"
    source_sha256 'daa1ff3a7efd6fed38cbf47bd26406858ba189562261e6840e2ae5683abd12b3'
  when 'i686'
    source_url "https://storage.googleapis.com/dart-archive/channels/stable/release/#{@_ver}/sdk/dartsdk-linux-ia32-release.zip"
    source_sha256 'b510bf547fae66ac2e5b345aeba5f669c67ec99e5d46e0341d264fa748e4f6f9'
  when 'x86_64'
    source_url "https://storage.googleapis.com/dart-archive/channels/stable/release/#{@_ver}/sdk/dartsdk-linux-x64-release.zip"
    source_sha256 '4d39fe12ef1fc2f1c98246c1f8482203398eb120f724c0789db8d4b2ffe25362'
  end

  binary_url({
  })
  binary_sha256({
  })

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
    FileUtils.cp_r 'bin/', CREW_DEST_PREFIX
    FileUtils.cp_r 'include/', CREW_DEST_PREFIX
    FileUtils.cp_r Dir.glob('lib/*'), CREW_DEST_LIB_PREFIX
    FileUtils.cp 'version', CREW_DEST_PREFIX # This stops 'pub get' from throwing errors
  end
end
