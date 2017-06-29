require 'package'

class Dart < Package
  description 'The Dart SDK is a set of tools and libraries for the Dart programming language.  You can find information about Dart online at dartlang.org.'
  homepage 'https://www.dartlang.org'
  version '1.24.2'
  case ARCH
  when 'i686'
    source_url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.24.2/sdk/dartsdk-linux-ia32-release.zip'
    source_sha256 '5b71cfe2331bea13227521c101bc7b3e8cfc8418c45615e6ea9dccf056bd323b'
  when 'x86_64'
    source_url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.24.2/sdk/dartsdk-linux-x64-release.zip'
    source_sha256 'f774330896e60df918848075f3f1d9ada414bcce4fe81504e2646a79536eb333'
  when 'armv7l'
    source_url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.24.2/sdk/dartsdk-linux-arm-release.zip'
    source_sha256 'c65d7ff111e396a9c7a691fc8470abe5e58cccdf70ef74c191d1cc527dc7c6fb'
  when 'aarch64'
    source_url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.24.2/sdk/dartsdk-linux-arm64-release.zip'
    source_sha256 'b547ad50f0208cdedf9bf432b5c1c41c8b6c53d9c5ff5ac4325460e8ba604e49'
#
#  comment out abort per discussion in #798
#  https://github.com/skycocker/chromebrew/pull/798
#  we have all current archs covered here anyway, i believe
#
#  else
#    abort 'Unable to install dart sdk.  Architecture not supported.'.lightred
  end

  depends_on 'unzip'

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local"
    system "cp -r bin/ #{CREW_DEST_DIR}/usr/local"
    system "cp -r lib/ #{CREW_DEST_DIR}/usr/local"
    system "cp -r include/ #{CREW_DEST_DIR}/usr/local"
  end
end
