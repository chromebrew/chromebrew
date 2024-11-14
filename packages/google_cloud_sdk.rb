require 'package'
Package.load_package("#{__dir__}/gcloud.rb")

class Google_cloud_sdk < Package
  description Gcloud.description
  homepage Gcloud.homepage
  version Gcloud.version
  license Gcloud.license
  compatibility Gcloud.compatibility

  is_fake

  depends_on 'gcloud'
end
